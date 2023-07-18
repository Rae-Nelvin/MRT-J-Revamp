//
//  TicketModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation

struct Ticket: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let currentTime: String
    let latitude: String
    let longitude: String
    
    init(name: String, email: String, currentTime: String, latitude: String, longitude: String) {
        self.name = name
        self.email = email
        self.currentTime = currentTime
        self.latitude = latitude
        self.longitude = longitude
    }
}
