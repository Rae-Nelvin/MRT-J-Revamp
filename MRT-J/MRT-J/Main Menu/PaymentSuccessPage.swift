//
//  PaymentSuccessPage.swift
//  MRT-J
//
//  Created by Eldrick Loe on 19/07/23.
//

import Foundation
import SwiftUI

struct PaymentSuccesPageView : View{
    var body: some View {
        ZStack{
            Image("Payment Success")
            VStack{
                Text("Payment Successful!")
                    .font(.title)
                    .bold()
                Text("You Have Completed Your Payment \n")
                Text("Total Paid")
                Text("Rp14.000")
                    .font(.title)
                    .bold()
            }
            .padding(.top, 150)
            .foregroundColor(Color.white)
        }
        .ignoresSafeArea()
    }
}

struct PaymentSuccesPageView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccesPageView()
    }
}
