//
//  AutomaticQRView.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 15/07/23.
//

import SwiftUI

struct TicketingView: View {
    @ObservedObject var tvm: TicketingViewModel = TicketingViewModel.shared
    @State var nvm: NotificationViewModel?
    @State private var qrCodeImage: UIImage? = nil
    
    var body: some View {
        VStack {
            Text("Scan QR code to enter")
                .font(.system(size: 24, weight: .semibold))
            ZStack(alignment: .leading) {
                Color(tvm.tpvm?.statusTap == .tapIn ? UIColor(.blue) : UIColor(.green))
                VStack(alignment: .leading) {
                    Text("Balance")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Rp. 20.000")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(uiImage: (tvm.tpvm?.qrCodeImage) ?? UIImage())
                        .resizable()
                        .frame(width: 270, height: 285)
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Refresh in 10s")
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
        .onReceive(tvm.tpvm?.objectWillChange ?? .init()) { _ in
            qrCodeImage = tvm.tpvm?.qrCodeImage
        }
        .onAppear() {
            tvm.checkTicket()
            nvm = NotificationViewModel(tvm: TicketingViewModel.shared)
        }
    }
}

struct AutomaticQRView_Previews: PreviewProvider {
    static var previews: some View {
        TicketingView()
    }
}
