//
//  TappingViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 19/07/23.
//

import Foundation
import SwiftUI

class TappingViewModel: ObservableObject {
    @Published var statusTap: Bool = false
    @Published var qrCodeImage: UIImage?
    
    var clvm: CoreLocationViewModel
    var qrg: QRGenerator
    var timer: Timer?
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
        self.clvm = CoreLocationViewModel()
        self.qrg = QRGenerator()
        clvm.locationManager.requestLocation()
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
