<?php

use App\Http\Controllers\MicroServicesApiController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/pricelist',[MicroServicesApiController::class,'index']);
Route::post('/buy',[MicroServicesApiController::class,'buy']);
Route::get('/balance',[MicroServicesApiController::class,'cekBalance']);