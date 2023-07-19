//
//  TicketingViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import SwiftUI

class TicketingViewModel: ObservableObject {
    
    @Published var tpvm: TappingViewModel?
    private var ravm: RESTAPIViewModel = RESTAPIViewModel()
    
    // MARK: Dummy Data
    let name = "Leonardo Wijaya"
    let email = "leonardo.wijaya003@binus.ac.id"
    
    init() {
        checkTicket()
    }
    
    private func checkTicket() {
        ravm.getTicket(name: self.name, email: self.email) { result in
            switch result {
            case .success(let ticket):
                if let ticket = ticket {
                    self.tpvm = TapOutViewModel(name: self.name, email: self.email, ticket: ticket)
                } else {
                    DispatchQueue.main.async {
                        self.tpvm = TapInViewModel(name: self.name, email: self.email)
                    } 
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
}
