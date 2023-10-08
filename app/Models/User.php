<?php

namespace App\Models;

use Tymon\JWTAuth\Contracts\JWTSubject;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable implements JWTSubject
{
  use HasFactory, Notifiable;

  public $timestamps = false;

  protected $hidden = [
    'password'
  ];

  // Função adicionada p/ JWT
  public function getJWTIdentifier()
  {
    return $this->getKey();
  }
  // Função adicionada p/ JWT
  public function getJWTCustomClaims()
  {
    return [];
  }
}
