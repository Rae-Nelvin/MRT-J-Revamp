//
//  TapInViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import CoreLocation

class TapInViewModel: TappingViewModel {
    
    override init(name: String, email: String, clvm: CoreLocationViewModel) {
        super.init(name: name, email: email, clvm: clvm)
        super.statusTap = .tapIn
        startTimer()
    }
    
    deinit {
        super.stopTimer()
    }
    
    override func generateDataForQRCode(name: String, email: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        let latitude = super.clvm.location?.coordinate.latitude.description
        let longitude = super.clvm.location?.coordinate.latitude.description
        let ticket = Ticket(name: super.name, email: super.email, tap_in_id: UUID().uuidString, tap_in_time: currentTime, tap_in_latitude: latitude ?? "nil", tap_in_longitude: longitude ?? "nil", tap_in_station: "DummyStation")
        guard let jsonData = generateJSONData(ticket: ticket) else { return }
        super.qrCodeImage = super.qrg.generateQRCode(apiEndpoint: "\(nvm.ravm.ngrokURL)/api/post/ticket/", requestData: jsonData)
    }
    
    override func startTimer() {
        generateDataForQRCode(name: self.name, email: self.email)
        timer()
        self.nvm.getNotification()
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] _ in
            self?.generateDataForQRCode(name: self?.name ?? "nil", email: self?.email ?? "nil")
            self?.objectWillChange.send()
            self?.timer()
            self?.nvm.getNotification()
        }
    }
    
    func timer() {
        timer2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if self?.timeLeft ?? 1 > 0 {
                self?.timeLeft -= 1
            } else {
                self?.timer2?.invalidate()
            }
        }
    }
    
}
