//
//  CardShimmer.swift
//  iGames
//
//  Created by Farhan Adji on 04/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct CardShimmer: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    var body: some View {
        ZStack {
            Color.black.opacity(0.10)
                .frame(height: 350)
                .cornerRadius(18)
            
            Color.white
            .frame(height: 350)
            .cornerRadius(18)
            .mask(
                Rectangle()
                .fill(
                    LinearGradient(
                        gradient: .init(colors: [.clear, Color.white.opacity(0.60), .clear]),
                        startPoint: .top,
                        endPoint: .bottom)
                )
                    .rotationEffect(.init(degrees: 90))
                    .offset(x: self.show ? center : -center)
            )
        }
    .padding()
        .onAppear {
            withAnimation(Animation.default.speed(0.15).delay(0)
                .repeatForever(autoreverses: false)){
                    self.show.toggle()
            }
        }
    }
}

struct CardShimmer_Previews: PreviewProvider {
    static var previews: some View {
        CardShimmer()
    }
}
