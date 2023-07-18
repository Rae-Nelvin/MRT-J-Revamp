<?php

namespace App\Http\Controllers;

use App\Models\Ticketing;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TicketingController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tickets = Ticketing::all();

        if ($tickets->isEmpty()) {
            return response()->json(['status' => 'error', 'message' => 'Tickets not found'], 404);
        }

        return response()->json(['status' => 'success', 'data' => $tickets], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store($jsonData)
    {
        $rules = [
            'name' => 'required|string',
            'email' => 'required|email|string',
            'tap_in_id' => 'required|string|unique:ticketings,tap_in_id',
            'tap_in_time' => 'required|date',
            'tap_in_latitude' => 'required',
            'tap_in_longitude' => 'required',
            'tap_in_station' => 'required|string'
        ];

        $data = json_decode($jsonData, true);
        $validator = Validator::make($data, $rules);
        
        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()
            ], 400);
        }

        $ticket = Ticketing::create($data);
        return response()->json(['status' => 'success', 'data' => $ticket], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($name, $email)
    {
        $ticket = Ticketing::where('name', $name)
                            ->where('email', $email)
                            ->where('tap_in_time', '>=', Carbon::today())
                            ->where('tap_in_time', '<', Carbon::tomorrow())
                            ->where('tap_out_time', '=', null)
                            ->first();

        if (!$ticket) {
            return response()->json(['status' => 'fail', 'data' => 'Ticket not found'], 404);
        }

        return response()->json(['status' => 'success', 'data' => $ticket], 200);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update($jsonData)
    {
        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|email',
            'tap_out_id' => 'required|string|unique:ticketings,tap_out_id',
            'tap_out_time' => 'required|date',
            'tap_out_latitude' => 'required',
            'tap_out_longitude' => 'required',
            'tap_out_station' => 'required|string',
        ];

        $data = json_decode($jsonData, true);
        $validator = Validator::make($data, $rules);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()
            ], 400);
        }

        $ticket = Ticketing::where('name', $data['name'])
                            ->where('email', $data['email'])
                            ->where('tap_out_time', '=', null)
                            ->first();

        if (!$ticket) {
            return response()->json([
                'status' => 'error',
                'message' => 'Tickets not found'
            ], 404);
        }

        // Move it to iOS
        if (Carbon::parse($data->tap_out_time)->diffInMinutes(Carbon::parse($ticket->tap_in_time)) < 5 || $data->tap_out_latitude == $ticket->tap_in_latitude || $data->tap_out_longitude == $ticket->tap_in_longitude || $data->tap_out_station == $ticket->tap_in_station) {
            return response()->json([
                'status' => 'error',
                'message' => 'You can\'t Tap Out in The Same Location'
            ], 406);
        }

        $ticket->fill($data);
        $ticket->save();
        return response()->json(['status' => 'success', 'data' => $ticket], 201);
    }
}
