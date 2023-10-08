<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

use App\Models\User;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // Unidades com usuário
        DB::table('units')->insert([
            'name' => 'APT 100',
            'id_owner' => '1'
        ]);
        DB::table('units')->insert([
            'name' => 'APT 101',
            'id_owner' => '1'
        ]);
        DB::table('units')->insert([
            'name' => 'APT 200',
            'id_owner' => '0'
        ]);
        DB::table('units')->insert([
            'name' => 'APT 201',
            'id_owner' => '0'
        ]);

        // Áreas Comuns (Academia)
        DB::table('areas')->insert([
            'allowed' => '1',
            'title' => 'Academia',
            'cover' => 'gyn.jpg',
            'days' => '1,2,4,5',
            'start_time' => '06:00:00',
            'end_time' => '22:00:00',
        ]);
        // Áreas Comuns (Piscina)
        DB::table('areas')->insert([
            'allowed' => '1',
            'title' => 'Piscina',
            'cover' => 'pool.jpg',
            'days' => '1,2,3,4,5',
            'start_time' => '06:00:00',
            'end_time' => '23:00:00',            
        ]);
        // Áreas Comuns (Churrasqueira)
        DB::table('areas')->insert([
            'allowed' => '1',
            'title' => 'Churrasqueira',
            'cover' => 'barbecue.jpg',
            'days' => '4,5,6',
            'start_time' => '07:00:00',
            'end_time' => '22:00:00',            
        ]);

        // Avisos do Mural
        DB::table('walls')->insert([
            'title' => 'Título de Aviso de Teste',
            'body' => 'Lorem ipsum bkablablabvblalvblassd',
            'datecreated' => '2020-12-20 15:00:00',
        ]);
        DB::table('walls')->insert([
            'title' => 'Alerta geral para TODOS',
            'body' => 'Bla bla bla cuidado bla bla bla',
            'datecreated' => '2020-12-20 18:00:00',
        ]);
    }
}
