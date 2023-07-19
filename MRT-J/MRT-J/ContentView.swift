//
//  ContentView.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 14/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 0
    var body: some View {
        VStack{
            Spacer()
            CustomTabBar(selection: $selection)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
