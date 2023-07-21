<?php

namespace App\Http\Controllers;

use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class NotificationController extends Controller
{
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
            'status' => 'required',
        ];

        $data = $request->all();
        $validator = Validator::make($data, $rules);
        
        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => $validator->errors()
            ], 400);
        }

        $notification = Notification::create($data);
        return response()->json(['status' => 'success', 'data' => $notification], 200);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($name, $email)
    {
        $notification = Notification::where('name', $name)
                            ->where('email', $email)
                            ->first();

        if (!$notification) {
            return response()->json(['status' => 'fail', 'data' => 'Notification not found'], 404);
        }

        return response()->json(['status' => 'success', 'data' => $notification], 200);
    }

    /**
     * Delete the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function delete($id)
    {
        $notification = Notification::where('id', $id)->first();

        if (!$notification) {
            return response()->json([
                'status' => 'error',
                'message' => 'Notification not found'
            ], 404);
        }

        $notification->delete();
        return response()->json([
            'status' => 'success',
            'message' => 'Notification have been deleted'
        ], 200);
    }
}
