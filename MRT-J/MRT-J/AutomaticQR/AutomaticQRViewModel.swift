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
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(name: String, email: String) -> UIImage {
        guard let data = generateJSONData(name: name, email: email) else { return UIImage(systemName: "xmark.circle") ?? UIImage() }
        filter.message = Data(data)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    private func generateJSONData(name: String, email: String) -> Data? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = dateFormatter.string(from: Date())
        
        let jsonDict: [String: Any] = [
            "name": name,
            "email": email,
            "timestamp": currentTime
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
