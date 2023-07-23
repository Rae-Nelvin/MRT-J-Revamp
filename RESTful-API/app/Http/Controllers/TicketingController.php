<?php

namespace App\Http\Controllers;

use App\Models\Notification;
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
            $this->createNotification('error', 'Tickets not found');
            return response()->json(['status' => 'error', 'message' => 'Tickets not found'], 404);
        }

        $this->createNotification('success', '');
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
            'tap_in_latitude' => 'required|string',
            'tap_in_longitude' => 'required|string',
            'tap_in_station' => 'required|string'
        ];

        $data = json_decode($jsonData, true);
        $validator = Validator::make($data, $rules);
        
        if ($validator->fails()) {
            $this->createNotification('error', $validator->errors());
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()
            ], 400);
        }

        $ticket = Ticketing::create($data);
        $this->createNotification('success', '');
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
            return response()->json(['status' => 'error', 'data' => 'Ticket not found'], 404);
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
            'tap_out_latitude' => 'required|string',
            'tap_out_longitude' => 'required|string',
            'tap_out_station' => 'required|string',
        ];

        $data = json_decode($jsonData, true);
        $validator = Validator::make($data, $rules);

        if ($validator->fails()) {
            $this->createNotification('error', $validator->errors());
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
            $this->createNotification('error', 'Tickets not found');
            return response()->json([
                'status' => 'error',
                'message' => 'Tickets not found'
            ], 404);
        }

        // To check if they tap out in the same location. Disabled for testing
        // if (Carbon::parse($data['tap_out_time'])->diffInMinutes(Carbon::parse($ticket->tap_in_time)) < 5 || $data['tap_out_latitude'] == $ticket->tap_in_latitude || $data['tap_out_longitude'] == $ticket->tap_in_longitude || $data['tap_out_station'] == $ticket->tap_in_station) {
        //     return response()->json([
        //         'status' => 'error',
        //         'message' => 'You can\'t Tap Out in The Same Location'
        //     ], 406);
        // }

        $ticket->tap_out_id = $data['tap_out_id'];
        $ticket->tap_out_time = $data['tap_out_time'];
        $ticket->tap_out_latitude = $data['tap_out_latitude'];
        $ticket->tap_out_longitude = $data['tap_out_longitude'];
        $ticket->tap_out_station = $data['tap_out_station'];
        $ticket->save();
        $this->createNotification('success', '');
        return response()->json(['status' => 'success', 'data' => $ticket], 201);
    }

    private function createNotification($status, $message) {
        $requestData = [
            'name' => 'Leonardo Wijaya',
            'email' => 'leonardo.wijaya003@binus.ac.id',
            'status' => $status,
            'message' => $message
        ];

        $request = new Request($requestData);

        (new NotificationController)->store($request);
    }
}
