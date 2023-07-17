<?php

namespace App\Http\Controllers;

use App\Models\Ticketing;
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
            return response()->json(['status' => 'error', 'message' => 'Data not found'], 404);
        }

        return response()->json(['status' => 'success', 'data' => $tickets], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $rules = [
            'name' => 'required|string',
            'email' => 'required|email|string',
            'tap_in_time' => 'required|date',
            'tap_in_latitude' => 'required',
            'tap_in_longitude' => 'required',
            'tap_in_station' => 'required|string'
        ];

        $data = $request->all();
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
    public function show(Ticketing $ticket)
    {
        return response()->json(['status' => 'success', 'data' => $ticket], 200);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $rules = [
            'name' => 'required|string',
            'email' => 'required|string|email',
            'tap_out_time' => 'required|date',
            'tap_out_latitude' => 'required',
            'tap_out_longitude' => 'required',
            'tap_out_station' => 'required|string',
        ];

        $data = $request->all();
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

        $ticket->fill($data);
        $ticket->save();
        return response()->json(['status' => 'success', 'data' => $ticket], 201);
    }
}
