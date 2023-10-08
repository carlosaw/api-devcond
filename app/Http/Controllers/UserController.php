<?php
// UserController.php:
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

use App\Models\User;

class UserController extends Controller
{
  // Pega todos os usuários
  public function getAll() {
    $array = ['error' => '', 'list' =>[]];
    $user = auth()->user();
    $users = User::all();
    $array['list'] = $users;
    return $array;
  }

  // Pega informações de um usuário
  public function getInfo($id) {
    $array = ['error' => ''];
    $users = User::find($id);
    if($users) {
      $users = User::where('id', $id)->get();
      foreach($users as $uKey => $uValue) {
        $users[$uKey]['name'] = $uValue['name'];
      }
      $array['users'] = $users;
    } else {
      $array['error'] = 'Usuário inexistente!';
      return $array;
    }   
    return $array;
  }

  // Modificar informações de um usuário
  public function update($id, Request $request) {
    $array = ['error' => ''];

    $validator = Validator::make($request->all(), [
      'name' => 'required',
      'email' => 'required|email',
      'cpf' => 'required|digits:11',
      'password' => 'required'
    ]);

    if(!$validator->fails()) {
      $name = $request->input('name');
      $email = $request->input('email');
      $cpf = $request->input('cpf');
      $password = $request->input('password');
      $hash = password_hash($password, PASSWORD_DEFAULT);
      if($name || $email || $cpf || $password) {
        $dados = User::find($id);
        if($dados) {
          $dados->name = $name;
          $dados->email = $email;
          $dados->cpf = $cpf;
          $dados->password = $hash;
          $dados->save();

          $array['user'] = [
            'id' => $id,
            'name' => $name,
            'email' => $email,
            'cpf' => $cpf,
            'password' => $password//$hash
          ];
        }
      } else {
        $array['error'] = 'Usuário inexistente!';
      }      
    } else {
      $array['error'] = $validator->errors()->first();
      return $array;
    }
    return $array;
  }
}