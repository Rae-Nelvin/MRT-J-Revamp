//
//  LoadingView.swift
//  MRT-J
//
//  Created by Eldrick Loe on 21/07/23.
//
import SwiftUI

struct LoadingView: View {
    @State private var isLoading = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 14)
                .frame(width: 100, height: 100)

            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.green, lineWidth: 7)
                .frame(width: 100, height: 100)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .onAppear {
                    startAnimating()
                }
        }
    }

    private func startAnimating() {
        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
            isLoading = true
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
