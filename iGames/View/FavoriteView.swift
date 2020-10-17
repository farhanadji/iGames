//
//  FavoriteView.swift
//  iGames
//
//  Created by Farhan Adji on 03/09/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @FetchRequest(
        entity: GamesFav.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \GamesFav.name, ascending: true)]
    ) var games: FetchedResults<GamesFav>
    @ObservedObject var contentVM: ContentViewModel = .shared
    var body: some View {
        VStack {
            if games.isEmpty {
                VStack(alignment: .center) {
                    Spacer()
                    Image(systemName: "gamecontroller")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("You don't have any favorite games. Explore now at Explore menu!")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    
                    Spacer()
                }
                .padding()
            } else {
                ForEach(self.games) { game in
                    FavoriteGameItem(
                        backgroundImage:
                            game.background_image,
                                     name: game.name,
                                     released: game.released)
                        .padding(.bottom, game == self.games.last ? 120 : 0)
                        .onTapGesture(perform: {
                            self.contentVM.showGameDetail(id: Int(game.id),
                                                          image: game.background_image,
                                                          name: game.name,
                                                          rating: game.rating,
                                                          released: game.released)
                        })
                }
            }
        }
        .padding(.top)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
