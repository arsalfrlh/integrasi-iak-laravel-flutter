<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class MicroSericesController extends Controller
{
    public function index(){
        return view('main.index');
    }

    public function pricelist(Request $request){
        $apiKey = config('iak.iak_api_key');
        $username = config('iak.iak_username');
        $signature = md5($username.$apiKey.'pl');
        $type = $request->type;
        $operator = $request->operator;
        try{
            $response = Http::post("https://prepaid.iak.id/api/pricelist/{$type}/{$operator}",[
                'status' => 'active',
                'username' => $username,
                'sign' => $signature,
            ]);
            $json = $response->json();
            return redirect()->back()->with('pricelist', $json);
        }catch (Exception $e){
            dd($e->getMessage());
        }
    }

    public function buy(Request $request){
        $code = $request->code;
        $costumerID = $request->costumer_id;
        $referenceID = 'Ref-'.uniqid();

        $apiKey = config('iak.iak_api_key');
        $username = config('iak.iak_username');
        $signature = md5($username.$apiKey.$referenceID);
        try{
            $response = Http::post('https://prepaid.iak.dev/api/top-up',[
                'customer_id' => $costumerID,
                'product_code' => $code,
                'ref_id' => $referenceID,
                'username' => $username,
                'sign' => $signature,
            ]);
            dd($response->json());
        }catch (Exception $e){
            dd($e->getMessage());
        }
    }
}
