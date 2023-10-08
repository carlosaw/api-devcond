<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use App\Models\Area;
use App\Models\AreaDisabledDay;
use App\Models\Reservation;
use App\Models\Unit;

class ReservationController extends Controller
{
  public function getReservations() {
    $array = ['error' => '', 'list' => []];
    $daysHelper = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];

    // Pegar áreas permitidas para reservas
    $areas = Area::where('allowed', 1)->get();
    // Pegar o nome dos dias
    /* Academia */
    // Seg-Ter 06:00 às 22:00
    // Qui-Sex 06:00 às 22:00
    /* Piscina */
    // Seg-Sex 07:00 às 23:00
    /* Churrasqueira */
    // Qui-Sab 09:00 às 23:00

    foreach($areas as $area) {
      $dayList = explode(',', $area['days']);

      $dayGroups = [];

      // Adicionando o primeiro dia
      $lastDay = intval(current($dayList));
      $dayGroups[] = $daysHelper[$lastDay];
      array_shift($dayList);

      // Adicionando dias relevantes
      foreach($dayList as $day) {
        if(intval($day) != $lastDay+1) {
          $dayGroups[] = $daysHelper[$lastDay];
          $dayGroups[] = $daysHelper[$day];
        }
        $lastDay = intval($day);
      }

      // Adicionando o último dia
      $dayGroups[] = $daysHelper[end($dayList)];

      // Juntando as datas (dia1-dia2)
      $dates = '';
      $close = 0;
      foreach($dayGroups as $group) {
        if($close === 0) {
          $dates .= $group;
        } else {
          $dates .= ' - '.$group.',';
        }
        $close = 1 - $close;
      }

      $dates = explode(',', $dates);
      array_pop($dates);

      // Adicionando o Time
      $start = date('H:i', strtotime($area['start_time']));
      $end = date('H:i', strtotime($area['end_time']));
      foreach($dates as $dKey => $dValue)  {
        $dates[$dKey] .= ' '.$start.' às '.$end;
      }
      /*echo "AREA: ".$area['title']."\n";
      print_r($dates);
      echo "\n----------";*/
      $array['list'][] = [
        'id' => $area['id'],
        'cover' => asset('storage/'.$area['cover']),
        'title' => $area['title'],
        'dates' => $dates
      ];
    }
    return $array;
  }

  public function setReservation($id, Request $request) {
    $array = ['error' => ''];

    $validator = Validator::make($request->all(), [
      'date' => 'required|date_format:Y-m-d',
      'time' => 'required|date_format:H:i:s',
      'property' => 'required'
    ]);
    if(!$validator->fails()) {
      $date = $request->input('date');// Pega a data
      $time = $request->input('time');// Pega horário
      $property = $request->input('property');// Pega a propriedade

      $unit = Unit::find($property);// Verifica propriedade
      $area = Area::find($id);// Verifica a área
      
      if($unit && $area) {// Se unidade e area existirem
        $can = true;
        $weekday = date('w', strtotime($date));

        // Verifica se está dentro da disponibilidade padrão.
        $allowedDays = explode(',', $area['days']);
        if(!in_array($weekday, $allowedDays)) {
          $can = false;
        } else {
          $start = strtotime($area['start_time']);
          $end = strtotime('-1 hour', strtotime($area['end_time']));
          $revtime = strtotime($time);
          if($revtime < $start || $revtime > $end) {
            $can = false;
          }
        }

        // Verificar se está dentro dos DisabledDays.
        $existingDisabledDay = AreaDisabledDay::where('id_area', $id)
        ->where('day', $date)
        ->count();
        if($existingDisabledDay > 0) {
          $can = false;
        }
        
        // Verificar se não existe outra reserva no mesmo dia/hora.
        $existingReservations = Reservation::where('id_area', $id)
        ->where('reservation_date', $date.' '.$time)
        ->count();
        if($existingReservations > 0) {
          $can = false;
        }
        // Faz a reserva
        if($can) {
          $newReservation = new Reservation();
          $newReservation->id_unit = $property;
          $newReservation->id_area = $id;
          $newReservation->reservation_date = $date.' '.$time;
          $newReservation->save();
        } else {
          $array['error'] = 'Reserva não permitida neste dia/horário.';
          return $array;
        }
      } else {
        $array['error'] = 'Dados incorretos!';
        return $array;
      }
    } else {
      $array['error'] = $validator->errors()->first();
      return $array;
    }

    return $array;
  }

  public function getDisabledDates($id) {
    $array = ['error' => '', 'list' => []];

    $area = Area::find($id);
    if($area) {
      // Dias desabilitados padrão
      $disabledDays = AreaDisabledDay::where('id_area', $id)->get();
      foreach($disabledDays as $disabledDay) {
        $array['list'][] = $disabledDay['day'];
      }

      // Dias disabled através do allowed
      $allowedDays = explode(',', $area['days']);
      $offDays = [];
      for($q=0;$q<7;$q++) {
        if(!in_array($q, $allowedDays)) {
          $offDays[] = $q;
        }
      }
      //print_r($allowedDays);
      //print_r($offDays);

      // Listar os dias proibidos +3 meses pra frente.
      $start = time();
      $end = strtotime('+3 months');
      $current = $start;
      
      for(
        $current = $start;
        $current < $end;
        $current = strtotime('+1 day', $current)
      ) {
        $wd = date('w', $current);// Pega dia da semana
        if(in_array($wd, $offDays)) {
          $array['list'][] = date('Y-m-d', $current);
        }
      }
    } else {
      $array['error'] = 'Área inexistente!';
      return $array;
    }
    return $array;
  }

  public function getTimes($id, Request $request) {
    $array = ['error' => '', 'list' => []];

    $validator = Validator::make($request->all(), [
      'date' => 'required|date_format:Y-m-d'
    ]);
    if(!$validator->fails()) {
      $date = $request->input('date');
      $area = Area::find($id);
      if($area) {
        $can = true;
        // Verificar se é dia disabled
        $existingDisabledDay = AreaDisabledDay::where('id_area', $id)
        ->where('day', $date)
        ->count();
        if($existingDisabledDay > 0) {
          $can = false;
        }
        // Verificar se é dia permitido
        $allowedDays = explode(',', $area['days']);
        $weekday = date('w', strtotime($date));
        if(!in_array($weekday, $allowedDays)) {
          $can = false;
        }

        if($can) {
          $start = strtotime($area['start_time']);
          $end = strtotime($area['end_time']);
          $times = [];

          for(
            $lastTime = $start;
            $lastTime < $end;
            $lastTime = strtotime('+1 hour', $lastTime)
          ) {
            $times[] = $lastTime;
          }
          //print_r($times);
          $timeList =[];
          foreach($times as $time){
            $timeList[] = [
              'id' => date('H:i:s', $time),
              'title' => date('H:i', $time).' - '.date('H:i', strtotime('+1 hour', $time))
            ];
          }

          // Pega a lista de reservas
          $reservations = Reservation::where('id_area', $id)
          ->whereBetween('reservation_date', [
            $date.' 00:00:00',
            $date.' 23:59:59'
          ])
          ->get();
          // Gera a lista de reservas para remover
          $toRemove = [];
          foreach($reservations as $reservation) {
            $time = date('H:i:s', strtotime($reservation['reservation_date']));
            $toRemove[] = $time;
          }
          // Remove da lista a reserva
          foreach($timeList as $timeItem) {
            if(!in_array($timeItem['id'], $toRemove)) {
              $array['list'][] = $timeItem;
            }
          }          
        }

      } else {
        $array['error'] = 'Área inexistente!';
      }
    } else {
      $array['error'] = $validator->errors()->first();
      return $array;
    }

    return $array;
  }

  public function getMyReservations(Request $request) {
    $array = ['error' => '', 'list' => []];
    // Pega a propriedade
    $property = $request->input('property');
    if($property) {
      // Pega as reservas daquela unidade
      $unit = Unit::find($property);
      if($unit) {
        $reservations = Reservation::where('id_unit', $property)
        ->orderBy('reservation_date', 'DESC')
        ->get();

        foreach($reservations as $reservation) {
          $area = Area::find($reservation['id_area']);

          $daterev = date('d/m/Y H:i', strtotime($reservation['reservation_date']));
          $aftertime = date('H:i', strtotime('+1 hour', strtotime($reservation['reservation_date'])));

          $daterev .= ' à '.$aftertime;

          $array['list'][] = [
            'id' => $reservation['id'],
            'id_area' => $reservation['id_area'],
            'title' => $area['title'],
            'cover' => asset('storage/'.$area['cover']),
            'datereserved' => $daterev
          ];
        }

      } else {
        $array['error'] = 'Propriedade inexistente!';
      }
    } else {
      $array['error'] = 'Propriedade necessária!';
    }

    return $array;
  }
  // Deletar minha reserva
  public function delMyReservation($id) {
    $array = ['error' => ''];

    $user = auth()->user();// Usuário logado
    $reservation = Reservation::find($id);// Pega a reserva
    if($reservation) {// se existir reserva
      // Verifica se a reserva da unidade é do usuário
      $unit = Unit::where('id', $reservation['id_unit'])
      ->where('id_owner', $user['id'])
      ->count();

      if($unit > 0) {
        Reservation::find($id)->delete();
      } else {
        $array['error'] = 'Esta reserva não é sua!';
        return $array;
      }
    } else {
      $array['error'] = 'Reserva inexistente!';
      return $array;
    }

    return $array;
  }
}
