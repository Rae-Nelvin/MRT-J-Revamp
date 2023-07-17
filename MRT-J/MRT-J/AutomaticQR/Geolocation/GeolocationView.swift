//
//  GeolocationView.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 17/07/23.
//

import SwiftUI

struct GeolocationView: View {
    @ObservedObject var geolocationVM: GeolocationViewModel = GeolocationViewModel()
    
    var body: some View {
        VStack {
            Text(geolocationVM.streetName ?? "Not detected")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.red)
//            if let latitude = geolocationVM.coreLocationVM.latitude, let longitude = geolocationVM.coreLocationVM.longitude {
//                geolocationVM.displayMap()
//                    .frame(height: 200)
//                    .cornerRadius(10)
//                    .padding()
//            } else {
//                Text("No location data available")
//                    .font(.system(size: 24, weight: .bold))
//                    .foregroundColor(.red)
//            }
            Text("You are here!")
                .font(.system(size: 24, weight: .bold))
        }
        .onAppear() {
            geolocationVM.performReverseGeocoding()
        }
    }
}

struct GeolocationView_Previews: PreviewProvider {
    static var previews: some View {
        GeolocationView()
    }
}
