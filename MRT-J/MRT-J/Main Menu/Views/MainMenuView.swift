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
    @ObservedObject private var tvm: TicketingViewModel = TicketingViewModel.shared
    @State var nvm: NotificationViewModel?
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading){
                    TrainPoisition()
                    Card(vm: self.vm)
                }
                .padding(.bottom, 10)
                VStack{
                    ScanTextSection(vm: vm)
                    QRSection(vm: vm)
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
        .onAppear() {
            nvm = NotificationViewModel(tvm: tvm)
        }
    }
    
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}

struct TrainPoisition: View {
    let tvm: TicketingViewModel = TicketingViewModel.shared
    
    var body: some View {
        HStack{
            Image(systemName: "location.fill")
                .font(.title)
                .foregroundColor(Color.white)
            Text("\(String(format: "%.2f", tvm.gvm.closestDistances ?? 0.0)) KM to \( tvm.gvm.closestStationName ?? "") Station")
                .bold()
                .font(.system(size: 17))
                .fontWeight(.bold)
                .foregroundColor(Color.white)
        }
    }
}

struct Card: View {
    let vm: MainMenuVM
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                CardText(text: "Balance", fontWeight: .medium, fontSize: 15)
                CardText(text: "Rp\(vm.balance)", fontWeight: .heavy, fontSize: 25)
                HStack{
                    CardButton(text: "+ Top Up") {
                        TopUpView(vm: self.vm)
                    }
                    .padding(.trailing, 5)
                    CardButton(text: "History", imageName: "list.bullet") {
                        HistoryView()
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
}

struct CardText: View {
    let text: String
    let fontWeight: Font.Weight
    let fontSize: CGFloat
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize))
            .fontWeight(fontWeight)
            .foregroundColor(Color.white)
            .bold()
    }
}

struct CardButton<Content: View>: View {
    let text: String
    let destination: () -> Content
    let imageName: String?
    
    init(text: String, imageName: String? = nil, destination: @escaping () -> Content) {
        self.text = text
        self.imageName = imageName
        self.destination = destination
    }
    
    var body: some View {
        NavigationLink(destination: destination()){
            HStack{
                if (imageName != nil) {
                    Image(systemName: imageName!)
                }
                Text(text)
            }
            .foregroundColor(Color.black)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}

struct ScanTextSection: View {
    @StateObject var vm: MainMenuVM
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                ScanText(text: "\(vm.scanTitle)", fontWeight: .bold, font: .title2)
                ScanText(text: "\(vm.scanSubtitle)", fontWeight: .semibold, font: .title3)
                Divider()
                    .frame(maxWidth: .infinity)
                    .overlay(.black)
            }
            .padding(.bottom, 20)
            Spacer()
        }
    }
}

struct ScanText: View {
    var text: String
    let fontWeight: Font.Weight
    let font: Font
    
    var body: some View {
        Text(text)
            .fontWeight(fontWeight)
            .font(font)
            .foregroundColor(Color(red:0.05, green:0.1, blue: 0.16))
            .multilineTextAlignment(.leading)
    }
}

struct QRSection: View {
    @StateObject var vm: MainMenuVM
    
    var body: some View {
        ZStack{
            Image("Doodle")
                .resizable()
                .contrast(2)
            if vm.showQR == false{
                hiddenQR(vm: vm)
            }
            else{
                shownQR(vm: vm)
            }
        }
        .frame(width: 345, height: 392)
        .frame(maxWidth: .infinity)
        .background(vm.qrBackground)
        .cornerRadius(10)
    }
}

struct hiddenQR: View {
    @StateObject var vm: MainMenuVM
    let tvm: TicketingViewModel = TicketingViewModel.shared
    
    var body: some View {
        Button {
            vm.showQR = true
            vm.isLoadingAnimation = true
            vm.startLoadingTimer()
            tvm.checkTicket()
        } label: {
            Text("Show QR Code")
                .foregroundColor(Color(red:0.05, green:0.1, blue: 0.16))
                .fontWeight(.heavy)
                .frame(width: 200, height: 40)
                .background(Color.white)
                .cornerRadius(20)
        }
    }
}

struct shownQR: View {
    @StateObject var vm: MainMenuVM
    var tvm: TicketingViewModel = TicketingViewModel.shared
    
    var body: some View {
        VStack{
            if tvm.isLoading == true{
                LoadingView()
            }
            else{
                Button{
                    if vm.alertMoneyInsufficient == false{
                        vm.checkBalance()
                        vm.qrScanIn.toggle()
                    }
                    else{
                        vm.checkBalance()
                    }
                } label: {
                    Image(uiImage: (tvm.tpvm?.qrCodeImage) ?? UIImage())
                        .resizable()
                        .frame(width: 250, height: 250)
                }
                .frame(width: 300 , height: 300)
                .background(Color.white)
                .cornerRadius(10)
                Text("Code reset in \(tvm.tpvm?.timeLeft ?? 0)s")
                    .foregroundColor(Color.white)
            }
        }
    }
}
