//
//  AutomaticQRViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 15/07/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Foundation

class AutomaticQRViewModel: ObservableObject {
    
    @Published var qrCodeImage: UIImage?
    
    private var coreLocationVM: CoreLocationViewModel = CoreLocationViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    private var timer: Timer?
    
    init() {
        coreLocationVM.locationManager.requestLocation()
        generateQRCode(name: "Leonardo Wijaya", email: "leonardo.wijaya003@binus.ac.id")
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { [weak self] _ in
            self?.generateQRCode(name: "Leonardo Wijaya", email: "leonardo.wijaya003@binus.ac.id")
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func generateQRCode(name: String, email: String) {
        guard let data = generateJSONData(name: name, email: email) else { return }
        filter.message = Data(data)
        filter.correctionLevel = "H"

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let scale = UIScreen.main.scale
                let resizedImage = UIImage(cgImage: cgimg, scale: scale, orientation: .up)
                let resizedQRImage = resizedImage.resizeImage(resizedImage, targetSize: CGSize(width: 200, height: 200))
                qrCodeImage = resizedQRImage
            }
        }
    }

    private func generateJSONData(name: String, email: String) -> Data? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        
        let jsonDict: [String: Any] = [
            "name": name,
            "email": email,
            "timestamp": currentTime,
            "latitude": coreLocationVM.locationManager.location?.coordinate.latitude.description ?? "nil",
            "longitude": coreLocationVM.locationManager.location?.coordinate.longitude.description ?? "nil"
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict, options: .prettyPrinted)
            return jsonData
        } catch {
            print("Error generating JSON data: \(error.localizedDescription)")
            return nil
        }
    }
    
}
