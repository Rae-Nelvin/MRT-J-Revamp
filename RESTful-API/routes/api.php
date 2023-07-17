<?php

use App\Http\Controllers\TicketingController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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

// Route::resources(['tickets' => TicketingController::class]);
Route::get('tickets', [TicketingController::class, 'index']);
Route::post('tickets', [TicketingController::class, 'store']);
Route::put('tickets', [TicketingController::class, 'update']);