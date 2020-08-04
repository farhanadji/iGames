//
//  DetailView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: DetailViewModel = DetailViewModel()
    var game: Games
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    WebImage(url: URL(string: game.background_image ?? ""))
                        .resizable()
                        .placeholder {
                            Rectangle().foregroundColor(.gray)
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(height: 280)
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.white)
                            .opacity(0.9)
                            .frame(width: 24, height: 24)
                    }
                    .padding(
                        EdgeInsets(
                            top: 20,
                            leading: 0,
                            bottom: 0,
                            trailing: 20))
                }
                VStack(spacing: 10) {
                    HStack {
                        Text((game.released?.toDate())?.getFormattedDate() ?? "-")
                            .font(.system(
                                size: 16,
                                weight: .semibold,
                                design: .default))
                            .foregroundColor(Color.black.opacity(0.3))
                        Spacer()
                        ForEach(game.parent_platforms) { item in
                            Image(item.slug ?? "")
                                .resizable()
                                .frame(width: 19, height: 19)
                        }
                    }
                    HStack {
                        Text(game.name ?? "-")
                            .font(.system(
                                size: 28,
                                weight: .bold,
                                design: .default))
                        Spacer()
                        RatingView(rating: game.rating ?? 0.0,
                                   size: 18,
                                   lineWidth: 2)
                    }.padding(.bottom, 20)
                    
                    Divider()
                    
                    if(vm.isLoading) {
                        ContentShimmer()
                    } else {
                        Text(self.vm.gameData.description_raw ?? "")
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(Color.black.opacity(0.8))
                            .padding(.top, 20)
                    }
                }.padding()
                .onAppear {
                        self.vm.getGameData(id: "\(self.game.id!)")
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("") //this must be empty
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
