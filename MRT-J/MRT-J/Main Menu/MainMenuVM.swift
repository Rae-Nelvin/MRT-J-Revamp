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
    @Published var stationDistance: Int = 2
    @Published var showQR: Bool = false
    @Published var qrImage: String = "qr"
    @Published var timeRemaining = 13
    @Published var timeLoadingRemaining = 2
    @Published private var timer: Timer? = nil
    @Published private var timer2: Timer? = nil
    @Published var scanTitle: String = "Entry QR Code"
    @Published var scanSubtitle: String = "Scan the code to start your trip"
    @Published var qrBackground: Color = Color.rgb(32,95,166)
    @Published var qrScanIn: Bool = false
    @Published var alertMoneyInsufficient : Bool = false
    @Published var alertMoneyInsufficientIsPresent: Bool = false
    @Published var showPaymentSheet: Bool = false
    @Published var isLoadingAnimation: Bool = false
    @Published var showLoadingAnimation: Bool = false
    
    init(){
        startTimer()
    }
    
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
        timeRemaining = 13
        self.showQR = false
//        self.qrScanIn = false
    }
    
    
    func startLoadingTimer() {
        if timer2 == nil {
            timer2 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if self.timeLoadingRemaining > 0 {
                    self.timeLoadingRemaining -= 1
                } else {
                    self.stopLoadingTimer()
                }
            }
        }
    }
    
    func stopLoadingTimer() {
        timer2?.invalidate()
        timer2 = nil
        timeLoadingRemaining = 2
        self.isLoadingAnimation = false
//        self.qrScanIn = false
    }
    
    func generateQrBackground(){
        if qrScanIn == true{
            self.scanTitle = "Exit QR Code"
            self.scanSubtitle =  "Scan the QR code to end your trip"
            qrBackground = Color.rgb(67,181,74)
            if self.balance < 14000{
                qrBackground = Color.red
            }
        }
        else{
            self.balance -= 14000
            self.scanTitle = "Entry QR Code"
            self.scanSubtitle =  "Scan the QR code to start your trip"
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
        else if qrScanIn == true{
            self.alertMoneyInsufficient = false
            self.alertMoneyInsufficientIsPresent = false
            qrBackground =  Color.rgb(67,181,74)
        }
        else if qrScanIn == false{
            self.alertMoneyInsufficient = false
            self.alertMoneyInsufficientIsPresent = false
            qrBackground = Color.rgb(32,95,166)
        }
    }
    
    func topUpBalance(){
        self.balance += 20000
    }
    
}

extension Color {
    static func rgb(_ red: Double, _ green: Double, _ blue: Double) -> Color {
        Color(red: red / 255.0, green: green / 255.0, blue: blue / 255.0)
    }
}
