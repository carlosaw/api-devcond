<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use App\Models\FoundAndLost;

class FoundAndLostController extends Controller
{
  public function getAll() {
    $array = ['error' => ''];
    // Pega lista dos PERDIDOS
    $lost = FoundAndLost::where('status', 'LOST')
    ->orderBy('datecreated', 'DESC')
    ->orderBy('id', 'DESC')
    ->get();
    // Pega lista dos ACHADOS
    $recovered = FoundAndLost::where('status', 'RECOVERED')
    ->orderBy('datecreated', 'DESC')
    ->orderBy('id', 'DESC')
    ->get();
    // Corrige a data e cria url e cria LOST
    foreach($lost as $lostKey => $lostValue) {
      $lost[$lostKey]['datecreated'] = date('d/m/Y', strtotime($lostValue['datecreated']));
      $lost[$lostKey]['photo'] = asset('storage/'.$lostValue['photo']);
    }
    // Corrige a data e cria url e cria RECOVERED
    foreach($recovered as $recKey => $recValue) {
      $recovered[$recKey]['datecreated'] = date('d/m/Y', strtotime($recValue['datecreated']));
      $recovered[$recKey]['photo'] = asset('storage/'.$recValue['photo']);
    }

    $array['lost'] = $lost;
    $array['recovered'] = $recovered;

    return $array;
  }

  public function insert(Request $request) {
    $array = ['error', ''];

    $validator = Validator::make($request->all(), [
      'description' => 'required',
      'where' => 'required',
      'photo' => 'required|file|mimes:jpg,png'
    ]);
    if(!$validator->fails()) {
      $description = $request->input('description');
      $where = $request->input('where');
      $file = $request->file('photo')->store('public');
      $file = explode('public/', $file);
      $photo = $file[1];

      $newLost = new FoundAndLost();
      $newLost->status = 'LOST';
      $newLost->photo = $photo;
      $newLost->description = $description;
      $newLost->where = $where;
      $newLost->datecreated = date('Y-m-d');
      $newLost->save();

    } else {
      $array['error'] = $validator->errors()->first();
      return $array;
    }

    return $array;
  }
  // Trocar o status
  public function update($id, Request $request) {
    $array = ['error' => ''];

    $status = $request->input('status');
    if($status && in_array($status, ['lost', 'recovered'])) {

      $item = FoundAndLost::find($id);
      if($item) {
        $item->status = $status;
        $item->save();
      } else {
        $array['error'] = 'Produto inexistente';
        return $array;
      }
    } else {
      $array['error'] = 'Status não existe';
      return $array;
    }

    return $array;
  }
}
