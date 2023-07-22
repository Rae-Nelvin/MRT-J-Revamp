//
//  HomeView.swift
//  MRT-J
//
//  Created by Eldrick Loe on 17/07/23.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MainMenuView: View {
    @ObservedObject private var vm = MainMenuVM()
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: "location.fill")
                            .font(.title)
                            .foregroundColor(Color.white)
                        Text("\(vm.currentTrainPosition[0]) Station")
                            .bold()
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    HStack{
                        VStack(alignment: .leading){
                            Text("Balance")
                                .foregroundColor(Color.white)
                                .font(.system(size: 15))
                                .fontWeight(.medium)
                                .bold()
                            Text("Rp\(vm.balance)")
                                .font(.system(size: 25))
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .bold()
                            HStack{
                                NavigationLink(destination: TopUpView(vm: vm)){
                                    HStack{
                                        Text("+ Top Up")
                                    }
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                }
                                .padding(.trailing, 5)
                                NavigationLink(destination: HistoryView()){
                                    HStack{
                                        Image(systemName: "list.bullet")
                                        Text("History")
                                    }
                                    .foregroundColor(Color.black)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
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
                .padding(.bottom, 10)
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(vm.scanTitle)")
                                .fontWeight(.bold)
                                //.bold()
                                .font(.title2)
                                .foregroundColor(Color(red:0.05, green:0.1, blue: 0.16))
                                .multilineTextAlignment(.leading)
                                
                            Text("\(vm.scanSubtitle)")
                                .fontWeight(.semibold)
                                .font(.title3)
                                .foregroundColor(Color(red:0.05, green:0.1, blue: 0.16))
                                .multilineTextAlignment(.leading)
                            Divider()
                                .frame(maxWidth: .infinity)
                                .overlay(.black)
                        }
                        .padding(.bottom, 20)
                        Spacer()
                    }
                    ZStack{
                        Image("Doodle")
                            .resizable()
                            .contrast(2)
                        if vm.showQR == false{
                            Button{
                                vm.showQR = true
                                vm.startTimer()
                            }label: {
                                Text("Show QR Code")
                                    //.bold()
                                    .foregroundColor(Color(red:0.05, green:0.1, blue: 0.16))
                                    .fontWeight(.heavy)
                                    .frame(width: 200, height: 40)
                                    .background(Color.white)
                                    .cornerRadius(20)
                            }
                        }
                        else{
                            VStack{
                                Button{
                                    vm.stopTimer()
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
                                        .cornerRadius(10)
                                }
                                Text("Code reset in \(vm.timeRemaining)s")
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                    .frame(width: 345, height: 392)
                    .frame(maxWidth: .infinity)
                    .background(vm.qrBackground)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(20)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .cornerRadius(15)
            }
            .padding(.top, 60)
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.12549019607843137, green: 0.37254901960784315, blue: 0.6509803921568628))
            .alert(isPresented: $vm.alertMoneyInsufficientIsPresent){
                {
                    Alert(title: Text("Insufficient Balance"),
                          message: Text("Please top up your balance and try again"),
                          dismissButton: .default(Text("OK")))
                }()
            }
            .sheet(isPresented: $vm.showPaymentSheet){
                PaymentSuccesPageView()
            }
        }
        .tint(Color.white)
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

