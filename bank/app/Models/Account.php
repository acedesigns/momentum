<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

/* USER DEFINED */
use App\User;

class Account extends Model
{
    use SoftDeletes;

    protected $table    = 'accounts';
    protected $dates    = ['created_at', 'updated_at', 'deleted_at'];
    protected $hidden   = ['created_at', 'updated_at', 'deleted_at'];

    protected $fillable = [
        'user_id', 'account_number', 'account_balance',
        'account_overdraft', 'account_type',
    ];


    public function user(){
        return $this->belongsTo(User::class);
    }
}
