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
                .resizable()
            VStack{
                Text("Payment Successful")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                Text("You have completed your payment")
                    .padding(.bottom, 13)
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                Text("Total Paid")
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("Rp14.000")
                    .font(.system(size: 34))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
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
