//
//  SearchView.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    @State private var navigationBarPadding: CGFloat = 0.0
    @ObservedObject private var searchVM: SearchViewModel = .shared
    @ObservedObject private var contentVM: ContentViewModel = .shared
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 30) {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.25)) {
                        self.contentVM.dismissSearchView()
                    }
                }) {
                    HStack {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 18, height: 18)
                        
                        Text("Back")
                            .font(.system(size: 17, weight: .semibold, design: .default))
                            .foregroundColor(Color.gray)
                    }
                }
                
                TextField("Search your favorite game..", text: self.$query, onCommit: {
                    self.searchVM.searchGame(query: self.query)
                })
                .font(.system(size: 22, weight: .semibold, design: .default))
            }
            .padding(.top, navigationBarPadding)
            .padding(.horizontal)
            
            
            VStack {
                if self.searchVM.isSearching {
                    if self.searchVM.isLoading {
                        SmallCardLoadingList(axes: .vertical)
                    } else {
                        if !self.searchVM.searchedGame.isEmpty {
                            ScrollView(.vertical) {
                                ForEach(self.searchVM.searchedGame) { game in
                                    FavoriteGameItem(
                                        backgroundImage: game.background_image ?? "",
                                        name: game.name ?? "",
                                        released: game.released)
                                        .onTapGesture(perform: {
                                            self.contentVM.showGameDetail(
                                                id: game.id,
                                                image: game.background_image,
                                                name: game.name,
                                                rating: game.rating,
                                                released: game.released)
                                        })
                                }
                            }
                        } else {
                            VStack(alignment: .center) {
                                Spacer()
                                Image(systemName: "xmark.octagon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                
                                Text("No results found.")
                                    .font(.system(size: 20, weight: .semibold, design: .default))
                                    .multilineTextAlignment(.center)
                                    .padding(.top)
                                
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(.top)
            
            Spacer(minLength: 0)
        }
        .edgesIgnoringSafeArea(.all)
        
        .onAppear(perform: {
            if #available(iOS 14.0, *) {
                self.navigationBarPadding = (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 45
            } else {
                self.navigationBarPadding = (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 90
            }
        })
        
        .onDisappear(perform: {
            self.searchVM.reset()
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
