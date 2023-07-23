//
//  TicketModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation

struct Ticket: Codable {
    var id: Int?
    let name: String
    let email: String
    let tap_in_id: String
    let tap_in_time: String
    let tap_in_latitude: String
    let tap_in_longitude: String
    let tap_in_station: String
    var tap_out_id: String?
    var tap_out_time: String?
    var tap_out_latitude: String?
    var tap_out_longitude: String?
    var tap_out_station: String?
    
    init(id: Int? = nil, name: String, email: String, tap_in_id: String, tap_in_time: String, tap_in_latitude: String, tap_in_longitude: String, tap_in_station: String, tap_out_id: String? = nil, tap_out_time: String? = nil, tap_out_latitude: String? = nil, tap_out_longitude: String? = nil, tap_out_station: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.tap_in_id = tap_in_id
        self.tap_in_time = tap_in_time
        self.tap_in_latitude = tap_in_latitude
        self.tap_in_longitude = tap_in_longitude
        self.tap_in_station = tap_in_station
        self.tap_out_id = tap_out_id
        self.tap_out_time = tap_out_time
        self.tap_out_latitude = tap_out_latitude
        self.tap_out_longitude = tap_out_longitude
        self.tap_out_station = tap_out_station
    }
}
