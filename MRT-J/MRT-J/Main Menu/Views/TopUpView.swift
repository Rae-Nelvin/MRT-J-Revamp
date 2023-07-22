//
//  TopUpView.swift
//  MRT-J
//
//  Created by Eldrick Loe on 21/07/23.
//


import Foundation
import SwiftUI

struct TopUpView : View{
    @ObservedObject var vm: MainMenuVM
    
    let paymentOptions: [TopUpModel] = [
        TopUpModel(imageName: "bca one klik", title: "BCA Oneklik"),
        TopUpModel(imageName: "BLU", title: "Blu by BCA Digital"),
        TopUpModel(imageName: "ALFA", title: "Alfamart, Alfamidi"),
        TopUpModel(imageName: "INDOMARET", title: "Indomaret"),
        TopUpModel(imageName: "MBCA", title: "m-BCA")
    ]
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    Text("Balance")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                    
                    Text("Rp.\(vm.balance)")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                }
                VStack{
                    HStack{
                        Text("Payment Method")
                            .font(.system(size: 24))
                            .bold()
                            .padding(.leading, 15)
                            .padding(.top, 27)
                        Spacer()
                    }
                    .padding(.bottom, 12)
                    
                    Divider()
                    VStack{
                        ForEach(paymentOptions) { option in
                            Button{
                                vm.topUpBalance()
                                vm.checkBalance()
                            }label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 342, height: 56)
                                        .foregroundColor(.clear)
                                        .background(.white)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .inset(by: 0.5)
                                            .stroke(.black, lineWidth: 1))
                                    
                                    HStack{
                                        Image("\(option.imageName)")
                                        Text("\(option.title)")
                                            .font(.system(size: 17))
                                            .bold()
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        Text(">")
                                            .font(.system(size: 17))
                                            .bold()
                                            .foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
        }
        .navigationTitle("Top Up")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.12549019607843137, green: 0.37254901960784315, blue: 0.6509803921568628))
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
                   UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
               }
               .onDisappear {
                   UINavigationBar.appearance().titleTextAttributes = nil
               }
    }
}



struct TopUpView_Previews: PreviewProvider {
    static var previews: some View {
        TopUpView(vm: MainMenuVM())
    }
}
