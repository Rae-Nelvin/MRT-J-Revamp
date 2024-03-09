//
//  TappingViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 19/07/23.
//

import Foundation
import SwiftUI

enum TappingStatus: String {
    case tapIn
    case tapOut
}

class TappingViewModel: ObservableObject {
    @Published var statusTap: TappingStatus?
    @Published var qrCodeImage: UIImage?
    @Published var timeLeft: Int = 15
    
    var clvm: CoreLocationViewModel
    var qrg: QRGenerator
    var nvm: NotificationViewModel = NotificationViewModel(tvm: TicketingViewModel.shared)
    var timer: Timer?
    var name: String
    var email: String
    var timer2: Timer?
    
    init(name: String, email: String, clvm: CoreLocationViewModel) {
        self.name = name
        self.email = email
        self.clvm = clvm
        self.qrg = QRGenerator()
        self.clvm.locationManager.requestLocation()
        self.objectWillChange.send()
    }
    
    deinit {
        stopTimer()
    }
    
    func generateDataForQRCode(name: String, email: String) {}
    
    func generateJSONData(ticket: Ticket) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(ticket)
            return jsonData
        } catch {
            print("Error generating JSON data: \(error.localizedDescription)")
            return nil
        }
    }
    
    func startTimer() {}
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
