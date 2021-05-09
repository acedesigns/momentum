<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/developer', function(Request $request) {
    return response()->json([
        'data' => [
            'name'  => 'Anele "ace" M ',
            'country' => "South Africa",
            'email'     => 'anele@acedesigns.co.za',
            'twitter'     => '@anele_ace',
        ],
    ], 200);
});


Route::post('/login', [
    'as'	=> 'user.login',
    'uses'	=> 'API\UserController@signInUser'
]);


Route::post('/register', [
    'as'	=> 'user.register',
    'uses'	=> 'API\UserController@registerUser'
]);

Route::group(['middleware' => ['jwt.auth'] ], function () {

    Route::get('/profile', [
        'as'	=> 'user.profile',
        'uses'	=> 'API\UserController@getUserProfile'
    ]);


    Route::post('/deposit', [
       'as' => 'user.deposit',
        'uses'  => 'API\UserController@depositToAccount'
    ]);


    Route::post('/withdraw', [
        'as' => 'user.withdraw',
        'uses'  => 'API\UserController@withDrawFromAccount'
    ]);


    Route::get('/logout', [
        'as'	=> 'user.logout',
        'uses'	=> 'API\UserController@logUserOut'
    ]);
});

