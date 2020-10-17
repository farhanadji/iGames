//
//  SmallCardShimmer.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
struct SmallCardLoadingList: View {
    var axes: Axis.Set = .horizontal
    var body: some View {
        ScrollView(axes, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(0..<6) { _ in
                    SmallCardShimmer()
                        .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

struct SmallCardShimmer: View {
    @State var show = false
    var center = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            Color.black.opacity(0.10)
                .frame(height: 100)
                .cornerRadius(18)
            
            Color.white
                .frame(height: 100)
            .cornerRadius(8)
            .mask(
                Rectangle()
                .fill(
                    LinearGradient(
                        gradient: .init(colors: [.clear, Color.white.opacity(0.60), .clear]),
                        startPoint: .leading,
                        endPoint: .trailing)
                )
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

struct SmallCardShimmer_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardLoadingList()
    }
}
