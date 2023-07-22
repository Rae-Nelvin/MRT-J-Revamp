//
//  HistoryModel.swift
//  MRT-J
//
//  Created by Eldrick Loe on 20/07/23.
//

import Foundation

struct HistoryModel: Identifiable, Hashable {
    let id = UUID()
    let date: String
    let time: String
    let description: String
    let balance: Int
    let paymentMethod: String
    let type: String
   
}

