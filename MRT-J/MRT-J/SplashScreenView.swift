//
//  SplashScreen.swift
//  MRT-J
//
//  Created by Eldrick Loe on 21/07/23.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Image("Splash Screen")
                .resizable()
                .scaledToFill()
        }
        .ignoresSafeArea()
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

