//
//  AutomaticQRView.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 15/07/23.
//

import SwiftUI

struct TicketingView: View {
    @ObservedObject var tvm: TicketingViewModel = TicketingViewModel()
    
    var body: some View {
        VStack {
            Text("Scan QR code to enter")
                .font(.system(size: 24, weight: .semibold))
            ZStack(alignment: .leading) {
                Color(hex: "#263558")
                VStack(alignment: .leading) {
                    Text("Balance")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Rp. 20.000")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        Spacer()
                    Image(uiImage: tvm.qrCodeImage ?? UIImage())
                        .resizable()
                        .frame(width: 270, height: 285)
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Refresh in 30s")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 24, leading: 34, bottom: 24, trailing: 34))
            }
            .frame(width: 337, height: 441)
            .cornerRadius(10)
        }
    }
}

struct AutomaticQRView_Previews: PreviewProvider {
    static var previews: some View {
        TicketingView()
    }
}
