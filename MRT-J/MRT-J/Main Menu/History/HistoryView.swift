//
//  HistoryView.swift
//  MRT-J
//
//  Created by Eldrick Loe on 20/07/23.
//

import SwiftUI

struct HistoryView: View {
    
    // Example payment history data
    let paymentHistory: [HistoryModel] = [
        HistoryModel(date: "2023-07-21", time: "22:22", description: "Top Up", balance: 100000, paymentMethod: "BCA OneKlik", type: "Top Up"),
        HistoryModel(date: "2023-07-21",time: "21:21", description: "Top Up", balance: 100000, paymentMethod: "BCA OneKlik", type: "Top Up"),
        HistoryModel(date: "2023-07-15",time: "12:21", description: "Lebak Bulus Grab", balance: 14000, paymentMethod: "Payment", type: "Mrt"),
        HistoryModel(date: "2023-07-10",time: "21:12", description: "Blok M", balance: 14000, paymentMethod: "Payment", type: "Mrt")
    ]
    
    var body: some View {
        ZStack{
            Color(red: 0.12549019607843137, green: 0.37254901960784315, blue: 0.6509803921568628)
                .edgesIgnoringSafeArea(.top)
            VStack {
                List {
                    let groupedEntries = Dictionary(grouping: paymentHistory) { $0.date }
                    ForEach(groupedEntries.keys.sorted(by: >), id: \.self) { date in
                        Section(header: Text(formatHeader(for: date)).font(.title2).foregroundColor(Color.black).bold()) {
                            ForEach(groupedEntries[date]!, id: \.self) { entry in
                                HStack {
                                    Text("\(entry.time)")
                                        .foregroundColor(Color.gray)
                                    if entry.type == "Mrt" {
                                        Image(systemName: "bus")
                                        VStack(alignment: .leading) {
                                            Text("\(entry.description)")
                                            Text("\(entry.paymentMethod)")
                                        }
                                        Spacer()
                                        Text("- Rp.\(entry.balance)")
                                    } else {
                                        Image(systemName: "plus.square.fill")
                                        VStack(alignment: .leading) {
                                            Text("\(entry.description)")
                                            Text("\(entry.paymentMethod)")
                                        }
                                        Spacer()
                                        Text("+ Rp.\(entry.balance)")
                                    }
                                }
                                .listRowBackground(Color.white)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                
            }
            .ignoresSafeArea()
            .navigationBarTitle("History")
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .onAppear {
                       UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
                   }
                   .onDisappear {
                       UINavigationBar.appearance().titleTextAttributes = nil
                   }
            
        }
    }
    
    func formatHeader(for dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM yyyy"
        
        let today = Calendar.current.startOfDay(for: Date())
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            if Calendar.current.isDate(date, inSameDayAs: today) {
                return "Today"
            } else if Calendar.current.isDate(date, inSameDayAs: yesterday) {
                return formatter.string(from: yesterday)
            } else {
                return formatter.string(from: date)
            }
        } else {
            return "Invalid Date"
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

