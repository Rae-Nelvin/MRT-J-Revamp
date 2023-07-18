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
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            if self?.statusTap == true {
                let _ = TapOutViewModel(tvm: self ?? TicketingViewModel())
            } else {
                let _ = TapInViewModel(tvm: self ?? TicketingViewModel())
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
                        let _ = TapOutViewModel(tvm: self)
                        break
                    } else {
                        self.statusTap = false
                        let _ = TapInViewModel(tvm: self)
                        break
                    }
                }
                self.statusTap = false
                let _ = TapInViewModel(tvm: self)
            } else {
                self.statusTap = false
                let _ = TapInViewModel(tvm: self)
            }
        }
    }
    
    func ticketsAppend(ticket: Ticket) {
        if self.tickets.count < 10 {
            self.tickets.append(ticket)
            print(ticket)
        } else {
            self.tickets.removeFirst()
        }
    }
}
