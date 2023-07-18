<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticketing extends Model
{
    use HasFactory;
    
    protected $table = 'ticketings';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'email',
        'tap_in_id',
        'tap_in_time',
        'tap_in_latitude',
        'tap_in_longitude',
        'tap_in_station',
        'tap_out_id',
        'tap_out_time',
        'tap_out_latitude',
        'tap_out_longitude',
        'tap_out_station'
    ];
}
