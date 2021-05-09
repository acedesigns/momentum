<?php

use Illuminate\Support\Str;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();

        $faker = Faker::create();

        DB::table('users')->insert([
            'full_name'         => "Bob Builder",
            'email'             => "bob@email.com",
            'password'          => bcrypt("pass"),
            'cellphone'         => $faker->phoneNumber,
            'isActive'          => true,
            'birthday'          => date('Y-m-d', strtotime( '-'.rand(18, 555).' months') ),
            'gender'            => $faker->randomElement(['m', 'f']),
            'user_age'          => rand(21, 76),
            'email_verified_at' => \Carbon\Carbon::now()->addHours(2),
            'remember_token'    => Str::random(20),
            'created_at'        => date('Y-m-d H:i:s', strtotime( '-'.rand(1, 55).' months') ),
            'updated_at'        => date_create()
        ]);


        DB::table('users')->insert([
            'full_name'         => "Jimmy Cricket",
            'email'             => "jimmy@email.com",
            'password'          => bcrypt("password"),
            'cellphone'         => $faker->phoneNumber,
            'isActive'          => true,
            'birthday'          => date('Y-m-d', strtotime( '-'.rand(11, 455).' months') ),
            'gender'            => $faker->randomElement(['m', 'f']),
            'user_age'          => rand(21, 76),
            'email_verified_at' => date('Y-m-d H:i:s', strtotime( '-'.rand(1, 20).' months') ),
            'remember_token'    => Str::random(20),
            'created_at'        => date('Y-m-d H:i:s', strtotime( '-'.rand(1, 55).' months') ),
            'updated_at'        => date_create()
        ]);
    }
}
