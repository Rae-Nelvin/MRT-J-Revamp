<?php

use App\Http\Controllers\NotificationController;
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
// Route::post('tickets', [TicketingController::class, 'store']);
Route::get('post/ticket/{jsonData}', [TicketingController::class, 'store']);
// Route::put('tickets', [TicketingController::class, 'update']);
Route::get('put/ticket/{jsonData}', [TicketingController::class, 'update']);
Route::get('ticket/{name}/{email}', [TicketingController::class, 'show']);
Route::get('notification/{name}/{email}', [NotificationController::class, 'show']);
Route::get('delete/notification/{id}', [NotificationController::class, 'delete']);