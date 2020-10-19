//
//  GameItem.swift
//  iGames
//
//  Created by Farhan Adji on 14/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameItem: View {
    var game: Games
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.background_image ?? ""))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
            }
            .renderingMode(.original)
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(height: 230)
            VStack(spacing: 0) {
                HStack {
                    if game.released != nil {
                        Text((game.released?.toDate())?.getFormattedDate() ?? "-")
                            .font(.system(
                                size: 16,
                                weight: .semibold,
                                design: .default))
                            .foregroundColor(Color.black.opacity(0.30))
                            .padding(.top, 12)
                    } else {
                        Text("To be announced")
                            .font(.system(size: 14, weight: .regular, design: .default))
                            .foregroundColor(Color.black.opacity(0.30))
                    }
                    Spacer()
                    ForEach(game.parent_platforms ?? []) { item in
                        Image(item.slug ?? "")
                            .resizable()
                            .frame(width: 19, height: 19)
                    }
                }
                HStack {
                    Text(game.name ?? "-")
                        .font(.system(
                            size: 25,
                            weight: .bold,
                            design: .default))
                        .fixedSize(horizontal: false, vertical: false)
                    Spacer()
                    RatingView(
                        rating: game.rating ?? 0.0,
                        size: 14,
                        lineWidth: 1
                    )
                        .frame(height: 5)
                }
                .padding(.bottom, 30)
            }.padding([.leading,.trailing])
        }
        .background(Color.white)
        .cornerRadius(18)
        .shadow(
            color: Color.black.opacity(0.18),
            radius: 4,
            x: 0,
            y: 4)
            .frame(height: 350)
            .padding([.leading,.trailing])
            .padding(.bottom, 10)
    }
}

