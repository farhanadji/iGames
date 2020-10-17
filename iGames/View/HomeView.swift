//
//  HomeView.swift
//  iGames
//
//  Created by Farhan Adji on 03/09/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var homeVM: HomeViewModel = .shared
    @ObservedObject var contentVM: ContentViewModel = .shared
    var body: some View {
        VStack(alignment: .leading) {
            if self.homeVM.isLoadingList {
                HomeShimmer()
            } else {
                VStack {
                    HStack{
                        Text("Special choices for you!")
                            .font(.system(
                                    size: 24,
                                    weight: .bold,
                                    design: .default))
                            .padding(.horizontal)
                        Spacer()
                    }.padding(.top, 20)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.homeVM.preferenceGame.suffix(5)) { game in
                                FavoriteGameItem(
                                    backgroundImage: game.background_image,
                                    name: game.name,
                                    released: game.released)
                                    .onTapGesture {
                                        withAnimation {
                                            self.contentVM.showGameDetail(id: game.id,
                                                                          image: game.background_image,
                                                                          name: game.name,
                                                                          rating: game.rating,
                                                                          released: game.released)
                                        }
                                    }
                            }
                        }
                    }
                }
                .onReceive(ProfileViewModel.shared.$preference, perform: { _ in
                    self.homeVM.getPreferencesGame()
                })
                
                Divider()
                    .padding(.top)
                HStack{
                    Text("Popular games")
                        .font(.system(
                                size: 24,
                                weight: .bold,
                                design: .default))
                        .padding(.horizontal)
                    Spacer()
                }.padding(.top, 20)
                
                
                ForEach(self.homeVM.popularGame.suffix(10)) { item in
                    GameItem(game: item)
                        .onTapGesture {
                            withAnimation {
                                self.contentVM.showGameDetail(id: item.id,
                                                              image: item.background_image,
                                                              name: item.name,
                                                              rating: item.rating,
                                                              released: item.released)
                            }
                        }
                }
                
                
                Divider()
                    .padding(.top)
                
                HStack{
                    Text("Top rated in 2020")
                        .font(.system(
                                size: 24,
                                weight: .bold,
                                design: .default))
                        .padding()
                    
                    Spacer()
                }
                VStack {
                    ForEach(self.homeVM.topRateGame) { item in
                        GameItem(game: item)
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                self.contentVM.showGameDetail(id: item.id,
                                                              image: item.background_image,
                                                              name: item.name,
                                                              rating: item.rating,
                                                              released: item.released)
                            }
                            .padding(.bottom, self.homeVM.topRateGame.last == item ? 120 : 0)
                    }
                    
                }
            }
        }
    }
}
