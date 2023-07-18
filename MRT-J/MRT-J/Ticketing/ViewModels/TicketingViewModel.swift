//
//  TicketingViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import SwiftUI

class TicketingViewModel: ObservableObject {
    @Published var statusTap: Bool = false
    @Published var qrCodeImage: UIImage?
    
    var clvm: CoreLocationViewModel = CoreLocationViewModel()
    var ravm: RESTAPIViewModel = RESTAPIViewModel()
    var aqrvm: QRGenerator = QRGenerator()
    
    var timer: Timer?
    var tickets: [Ticket] = []
    // MARK: Dummy Data
    let name = "Leonardo Wijaya"
    let email = "leonardo.wijaya003@binus.ac.id"
    
    init() {
//        checkTicket()
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            if self?.statusTap == true {
                let _ = TapOutViewModel()
            } else {
                let _ = TapInViewModel()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func checkTicket() {
        ravm.getTicket(name: self.name, email: self.email) { data in
            if let data = data {
                for ticket in self.tickets {
                    if let tapInID = UUID(uuidString: data["tap_in_id"] as! String), ticket.id == tapInID {
                        self.statusTap = true
                        print(1)
//                        let _ = TapInViewModel()
//                        break
                    } else {
                        self.statusTap = false
                        print(2)
//                        let _ = TapOutViewModel()
//                        break
                    }
                }
                self.statusTap = false
                print(3)
//                let _ = TapOutViewModel()
            } else {
                self.statusTap = false
                print(4)
                TapOutViewModel()
            }
        }
    }
    
    func ticketsAppend(ticket: Ticket) {
        if self.tickets.count < 2 {
            self.tickets.append(ticket)
        } else {
            self.tickets.remove(at: 0)
        }
    }
}
