//
//  HomeVM.swift
//  MRT-J
//
//  Created by Eldrick Loe on 17/07/23.
//

import Foundation
import SwiftUI


class MainMenuVM: ObservableObject{
    @Published var name: String = "Helen"
    @Published var balance: Int = 100000
    @Published var currentTrainPosition = ["Lebak Bulus Grab", "Fatmawati Indomaret", "Cipete Raya", "Haji Nawi", "Blok A", "Blok M BCA", "ASEAN", "Senayan", "Istora Mandiri", "Bendungan Hilir", "SetiaBbudi Astra", "Dukuh Atas BNI", "Bundaran HI"]
    @Published var showQR: Bool = false
    @Published var qrImage: String = "qr"
    @Published var timeRemaining = 5
    @Published private var timer: Timer? = nil
    @Published var scanTitle: String = "Entry QR Code"
    @Published var scanSubtitle: String = "Scan the code to start your trip"
    @Published var qrBackground: Color = Color.rgb(32,95,166)
    @Published var qrScanIn: Bool = false
    @Published var alertMoneyInsufficient : Bool = false
    @Published var alertMoneyInsufficientIsPresent: Bool = false
    @Published var showPaymentSheet: Bool = false
    
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopTimer()
                }
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        timeRemaining = 5
        self.showQR = false
//        self.qrScanIn = false
    }
    
    func generateQrBackground(){
        if qrScanIn == true{
            self.scanTitle = "Exit QR Code"
            self.scanSubtitle =  "Scan the code to end your trip"
            qrBackground = Color.rgb(39,111,61)
            if self.balance < 14000{
                qrBackground = Color.red
            }
        }
        else{
            self.balance -= 14000
            self.scanTitle = "Entry QR Code"
            self.scanSubtitle =  "Scan the code to start your trip"
            qrBackground = Color.rgb(32,95,166)
            self.showPaymentSheet = true
        }
    }
    
    func checkBalance(){
        if self.balance < 14000{
            self.alertMoneyInsufficient = true
            self.alertMoneyInsufficientIsPresent = true
            qrBackground = Color.red
        }
        else{
            self.alertMoneyInsufficient = false
            self.alertMoneyInsufficientIsPresent = false
            qrBackground = Color.rgb(39,111,61)
        }
    }
    
}

extension Color {
    static func rgb(_ red: Double, _ green: Double, _ blue: Double) -> Color {
        Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
}
