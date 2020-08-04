//
//  HomeTitleShimmer.swift
//  iGames
//
//  Created by Farhan Adji on 04/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct HomeTitleShimmer: View {
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    var body: some View {
        ZStack {
            Color.black.opacity(0.10)
                .frame(width: 280, height: 28)
            
            Color.white
                .frame(width: 280, height: 100)
                .mask(
                    Capsule()
                        .fill(
                            LinearGradient(
                                gradient: .init(colors: [.clear, Color.white.opacity(0.40),
                                                         .clear]),
                                startPoint: .top,
                                endPoint: .bottom)
                    )
                        .rotationEffect(.init(degrees: 30))
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

struct HomeTitleShimmer_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitleShimmer()
    }
}
