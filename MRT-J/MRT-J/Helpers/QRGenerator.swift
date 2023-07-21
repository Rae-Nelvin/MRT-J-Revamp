//
//  AutomaticQRViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 15/07/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import Foundation

class QRGenerator {
    
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(apiEndpoint: String, requestData: Data) -> UIImage? {
        let jsonString = String(data: requestData, encoding: .utf8)
        
        let urlString = apiEndpoint + jsonString!
        
        guard let data = urlString.data(using: .utf8) else {
            return nil
        }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.correctionLevel = "H"

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                let scale = UIScreen.main.scale
                let resizedImage = UIImage(cgImage: cgimg, scale: scale, orientation: .up)
                let resizedQRImage = resizedImage.resizeImage(resizedImage, targetSize: CGSize(width: 200, height: 200))
                return resizedQRImage
            }
        }
        
        return nil
    }
    
}
