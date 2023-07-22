//
//  MRT_JApp.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 14/07/23.
//

import SwiftUI

@main
struct MRT_JApp: App {
    @ObservedObject private var tvm: TicketingViewModel = TicketingViewModel.shared
    @State private var showSplashScreen = true
    
    var body: some Scene {
        WindowGroup {
            if tvm.location == nil {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                MainMenuView()
            }
        }
    }
}
