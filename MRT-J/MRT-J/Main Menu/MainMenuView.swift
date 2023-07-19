//
//  HomeView.swift
//  MRT-J
//
//  Created by Eldrick Loe on 17/07/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MainMenuView: View {
    @StateObject private var vm = MainMenuVM()
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "location.fill")
                            .font(.title)
                        Text("\(vm.currentTrainPosition[0])")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color.white)
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Balance")
                                .foregroundColor(Color.white)
                                .font(.headline)
                            Text("Rp\(vm.balance)")
                                .font(.title)
                                .foregroundColor(Color.white)
                                .bold()
                            HStack{
                                Button{
                                    vm.balance += 100000
                                    vm.checkBalance()
                                }label: {
                                    
                                    Text("+ Top Up")
                                        .foregroundColor(Color.black)
                                    
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 3)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                Button{
                                    
                                }label: {
                                    HStack{
                                        Image(systemName: "list.bullet")
                                        Text("History")
                                    }
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                }
                            }
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
                    .frame(width: 355, height: 140)
                    .background(Color(red: 0.054901960784313725, green: 0.10196078431372549, blue: 0.16470588235294117))
                    .cornerRadius(10)
                }
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(vm.scanTitle)")
                                .bold()
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                            
                            Text("\(vm.scanSubtitle)")
                                .font(.title3)
                                .multilineTextAlignment(.leading)
                            Divider()
                                .overlay(.black)
                        }
                        Spacer()
                    }
                    ZStack{
                        Image("Doodle")
                            .resizable()
                        if vm.showQR == false{
                            Button{
                                vm.showQR = true
                                vm.startTimer()
                            }label: {
                                Text("Show QR Code")
                                    .bold()
                                    .foregroundColor(Color.black)
                                    .frame(width: 200, height: 40)
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                        else{
                            VStack{
                                Button{
                                    if vm.alertMoneyInsufficient == false{
                                        vm.checkBalance()
                                        vm.qrScanIn.toggle()
                                        vm.generateQrBackground()
                                    }
                                    else{
                                        vm.checkBalance()
                                    }
                                }label: {
                                    Image("\(vm.qrImage)")
                                        .resizable()
                                        .frame(width: 250, height: 250)
                                }
                                Text("Code reset in \(vm.timeRemaining)s")
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .border(Color.black)
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .background(vm.qrBackground)
                    .cornerRadius(10)
                    
                    
                    
                    Spacer()
                    
                }
                .padding(20)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(10)
            }
            .padding(.top, 60)
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.12549019607843137, green: 0.37254901960784315, blue: 0.6509803921568628))
            .alert(isPresented: $vm.alertMoneyInsufficientIsPresent){
                {
                    Alert(title: Text("Insufficient Balance"),
                          message: Text("Please top up your account"),
                          dismissButton: .default(Text("OK")))
                }()
            }
            .sheet(isPresented: $vm.showPaymentSheet){
                PaymentSuccesPageView()
            }
        }
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

