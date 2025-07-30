<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;

class MicroServicesApiController extends Controller
{
    public function index(Request $request){
        $validator = Validator::make($request->all(),[
            'type' => 'required',
            'operator' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(['message' => $validator->errors()->all(), 'success' => false]);
        }

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

            $data = $response->json();
            return response()->json(['message' => "Menampilkan semua data pencarian", "success" => true, 'data' => $data]);
        }catch (Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false, 'data' => []]);
        }
    }

    public function buy(Request $request){
        $validator = Validator::make($request->all(),[
            'code' => 'required',
            'costumer_id' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(['message' => $validator->errors()->all(), 'success' => false]);
        }

        $code = $request->code;
        $kostumerID = $request->costumer_id;
        $referenceID = 'Ref-'.uniqid();

        $apiKey = config('iak.iak_api_key');
        $username = config('iak.iak_username');
        $signature = md5($username.$apiKey.$referenceID);

        try{
            $response = Http::post('https://prepaid.iak.dev/api/top-up',[
                'customer_id' => $kostumerID,
                'product_code' => $code,
                'ref_id' => $referenceID,
                'username' => $username,
                'sign' => $signature,
            ]);
            $data = $response->json();
            return response()->json(['message' => 'Pembelian berhasil', 'success' => true, 'data' => $data]);
        }catch(Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false]);
        }
    }

    public function cekBalance(){
        $apiKey = config('iak.iak_api_key');
        $username = config('iak.iak_username');
        $signature = md5($username.$apiKey."bl");
        try{
            $response = Http::post('https://prepaid.iak.dev/api/check-balance',[
                'username' => $username,
                'sign' => $signature,
            ]);
            
            $data = $response->json();
            return response()->json(['message' => "Berhasil menampilkan saldo anda", 'success' => true, 'data' => $data]);
        }catch(Exception $e){
            return response()->json(['message' => $e->getMessage(), 'success' => false]);
        }
    }
}
