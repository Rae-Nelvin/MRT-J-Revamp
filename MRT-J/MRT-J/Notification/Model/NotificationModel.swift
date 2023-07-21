//
//  NotificationModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 20/07/23.
//

import Foundation

struct Notification: Codable {
    let id: Int
    let name: String
    let email: String
    let status: String
    let message: String?
    
    init(id: Int, name: String, email: String, status: String, message: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.status = status
        self.message = message
    }
}

enum NotificationStatus: String {
    case success
    case error
}
