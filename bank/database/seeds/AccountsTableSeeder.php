<?php

use Illuminate\Support\Str;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;

use App\Models\Account;

class AccountsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();

        for ($i = 0; $i < 3; $i++) {
            Account::create([
                'user_id'   => rand(1,2),
                'account_number'    => rand(1111111, 9999999),
                'account_balance'   => rand(111, 9999),
                'account_overdraft' => rand(0, 9999),
                'account_type'      => $faker->randomElement(['lo','cr','ch']),
                'created_at'        => date('Y-m-d H:i:s', strtotime( '-'.rand(1, 55).' months') ),
                'updated_at'        => date_create()
            ]);
        }
    }
}
