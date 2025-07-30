<?php

use App\Http\Controllers\MicroSericesController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/index',[MicroSericesController::class,'index']);
Route::post('/pricelist',[MicroSericesController::class,'pricelist']);
Route::post('/buy',[MicroSericesController::class,'buy']);
