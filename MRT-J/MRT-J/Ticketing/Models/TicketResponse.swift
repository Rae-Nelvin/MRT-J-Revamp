//
//  TicketResponse.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 19/07/23.
//

import Foundation

struct TicketResponse: Codable {
    let status: String
    let data: Ticket
}
