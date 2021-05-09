<?php

namespace App\Http\Controllers\API;


use App\Models\Account;
use Carbon\Carbon;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Tymon\JWTAuth\Exceptions\JWTException;

use App\User;

class UserController extends Controller
{

    private function exceptionResponse ($exception) {
        return response()->json([
            'error' => 'An error occurred '. $exception->getMessage() ." ". $exception->getLine()
        ], 500);
    }


    public function signInUser( Request $request ) {

        $this->validate( $request, [
            'email' 	=> 'required|email',
            'password' 	=> 'required',
        ]);

        $credentials = $request->only('email', 'password') + ['isActive' => true ];

        try {
            if(!$token = JWTAuth::attempt( $credentials )) {
                return response()->json(['error' => 'Invalid Credentials or Please activate Your Account', 'code'  => 401], 401);
            }
        } catch (JWTException $ex) {
            return response()->json(['error' => $ex, 'code' => 500],500);
        }

        $user = \Auth::user();

        return response()->json(['token' => $token, 'code'  => 200, 'user' => $user->with('accounts')->where('id', $user->id)->first()], 200);
    }


    public function registerUser( Request $request ){

        $this->validate( $request, [
            'full_name' 	=> 'required|string|max:255',
            'email' 	    => 'required|string|email|max:255|unique:users',
            'password' 	    => 'required|string|min:6',
            'cellphone' 	=> 'required',
            'gender' 	    => 'required',
            'birthday' 	    => 'required',
        ]);

        $user =  User::create([
            'full_name' => $request->full_name,
            'cellphone' => $request->cellphone,
            'email'     => $request->Input('email'),
            'gender'    => $request->get('gender'),
            'birthday'  => Carbon::parse($request->birthday)->format('Y-m-d'),
            'password'  => bcrypt($request->get('password')),
            'token'		=> Str::random(40),
            'isActive'	=> false,
            'remember_token'    => Str::random(20),
            'device_token'      => $request->device_token
        ]);

        UserRole::create([
            'user_id' 	=> $user->id,
            'role_id'	=> 3
        ]);

        $userInfo = [
            'email'	=> $request->email,
            'username'  => $request->full_name,
            'token'	=> $user->token
        ];


        if( $user  ) {

            Mail::to( $request->email )->send( new NewUserRegistration ($userInfo));

            return response()->json(['message'	=> 'Successfully created an Account. Please check Your email for further instructions'], 201);
        } else {
            return response()->json(['message'	=> 'Could Not Register'], 401);
        }

    }


    public function getUserProfile( Request $request  ) {

        if (!$user = JWTAuth::parseToken()->authenticate()) {
            return response()->json(['user' => "Not Found"], 404);
        }

        $profile = User::with('accounts')->where('id', $user->id)->first();

        return response()->json($profile, 200);
    }


    public function logUserOut( Request $request ) {


        if (!$user = JWTAuth::parseToken()->authenticate()) {
            return response()->json(['user' => "Not Found"], 404);
        }

        try {

            JWTAuth::invalidate(JWTAuth::parseToken()->authenticate());
            return response()->json([
                'code' => 200,
                'message' => 'User logged out successfully'
            ]);
        } catch ( \Exception $exception ) {
            return response()->json([
                'code' => 500,
                'message' => 'Sorry, the user cannot be logged out'
            ], 500);
        }

    }


    public function depositToAccount( Request $request ) {
        if (!$user = JWTAuth::parseToken()->authenticate()) {
            return response()->json(['user' => "Not Found", "code" => 404], 404);
        }

        $account = Account::where('user_id', $user->id)->where('id', $request->account_id)->first();

        Account::where('user_id', $user->id)
            ->where('id', $request->account_id)
            ->update([
            'account_balance' => $request->account_amount + $account->account_balance
        ]);

        return response()->json(['code' => 200, 'balance' => $account], 200);
    }


    public function withDrawFromAccount( Request $request ) {
        if (!$user = JWTAuth::parseToken()->authenticate()) {
            return response()->json(['user' => "Not Found", "code" => 404], 404);
        }

        $account = Account::where('user_id', $user->id)->where('id', $request->account_id)->first();

        Account::where('user_id', $user->id)
            ->where('id', $request->account_id)
            ->update([
                'account_balance' => $account->account_balance - $request->account_amount
            ]);

        return response()->json(['code' => 200, 'balance' => $account], 200);
    }

}
