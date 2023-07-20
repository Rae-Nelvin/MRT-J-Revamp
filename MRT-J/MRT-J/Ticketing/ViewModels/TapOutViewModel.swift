//
//  TapOutViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import CoreLocation

class TapOutViewModel: TappingViewModel {
    
    private var ticket: Ticket
    
    init(name: String, email: String, ticket: Ticket, clvm: CoreLocationViewModel) {
        self.ticket = ticket
        super.init(name: name, email: email, clvm: clvm)
        generateDataForQRCode(name: super.name, email: super.email)
        startTimer()
        super.statusTap = .tapOut
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
        ticket.tap_out_id = UUID().uuidString
        ticket.tap_out_time = currentTime
        ticket.tap_out_latitude = latitude
        ticket.tap_out_longitude = longitude
        ticket.tap_out_station = "DummyStation2"
        guard let jsonData = generateJSONData(ticket: ticket) else { return }
        super.qrCodeImage = super.qrg.generateQRCode(apiEndpoint: "\(nvm.ravm.ngrokURL)/api/put/ticket/", requestData: jsonData)
    }
    
    override func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            self?.generateDataForQRCode(name: self?.name ?? "nil", email: self?.email ?? "nil")
            self?.nvm.getNotification()
            self?.objectWillChange.send()
        }
    }
}
