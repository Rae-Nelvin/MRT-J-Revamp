//
//  TapInViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 18/07/23.
//

import Foundation
import CoreLocation

class TapInViewModel: TappingViewModel {
    
    override init(name: String, email: String) {
        super.init(name: name, email: email)
        generateDataForQRCode(name: super.name, email: super.email)
        startTimer()
    }
    
    deinit {
        super.stopTimer()
    }
    
    func generateDataForQRCode(name: String, email: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        let latitude = super.clvm.location?.coordinate.latitude.description
        let longitude = super.clvm.location?.coordinate.latitude.description
        let ticket = Ticket(name: super.name, email: super.email, tap_in_id: UUID().uuidString, tap_in_time: currentTime, tap_in_latitude: latitude ?? "nil", tap_in_longitude: longitude ?? "nil", tap_in_station: "DummyStation")
        guard let jsonData = generateJSONData(ticket: ticket) else { return }
        super.qrCodeImage = super.qrg.generateQRCode(apiEndpoint: "https://3691-103-154-141-89.ngrok-free.app/api/put/ticket/", requestData: jsonData)
    }
    
    private func generateJSONData(ticket: Ticket) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(ticket)
            return jsonData
        } catch {
            print("Error generating JSON data: \(error.localizedDescription)")
            return nil
        }
    }
    
}

extension TapInViewModel: TappingProtocol {
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.generateDataForQRCode(name: self?.name ?? "nil", email: self?.email ?? "nil")
        }
    }
}
