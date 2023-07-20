//
//  TicketingViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import SwiftUI
import CoreLocation

class TicketingViewModel: ObservableObject {
    
    static let shared: TicketingViewModel = TicketingViewModel()
    
    @Published var tpvm: TappingViewModel?
    private let ravm: RESTAPIViewModel = RESTAPIViewModel()
    let clvm: CoreLocationViewModel = CoreLocationViewModel()
    @Published var location: CLLocation?
    @Published var statusTicketing: NotificationStatus?
    
    // MARK: Dummy Data
    let name = "Leonardo Wijaya"
    let email = "leonardo.wijaya003@binus.ac.id"
    
    init() {
        DispatchQueue.main.async {
            self.location = self.clvm.location
        }
    }
    
    func checkTicket() {
        ravm.getTicket(name: self.name, email: self.email) { result in
            switch result {
            case .success(let ticket):
                if let ticket = ticket {
                    DispatchQueue.main.async {
                        self.tpvm = TapOutViewModel(name: self.name, email: self.email, ticket: ticket, clvm: self.clvm)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.tpvm = TapInViewModel(name: self.name, email: self.email, clvm: self.clvm)
                    }
                }
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
}
