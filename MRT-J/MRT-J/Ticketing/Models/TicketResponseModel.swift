//
//  TicketResponse.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 19/07/23.
//

import Foundation

struct TicketResponseModel: Codable {
    let status: String
    let data: Ticket
}
