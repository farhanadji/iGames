//
//  ContentView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

enum HomeView {
    case profile
    case detail
}

struct ContentView: View {
    @State var isShowModal: Bool = false
    @State var selectedView: HomeView = .profile
    @State var selectedGame: Games = Games(id: 0, slug: "", name: "", released: "", background_image: "", rating: 0.0, parent_platforms: [], genres: [])
    @ObservedObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if self.vm.isLoadingList {
                    HomeShimmer()
                } else {
                    List {
                        Section(header:
                            HStack{
                                Text("Popular games")
                                    .font(.system(
                                        size: 28,
                                        weight: .bold,
                                        design: .default))
                                    .padding()
                                
                                Spacer()
                            }
                            .padding(0)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0))
                                .background(Color.white)
                        ) {
                            ForEach(self.vm.popularGame) { item in
                                GameItem(game: item)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        self.selectedGame = item
                                        self.selectedView = .detail
                                        self.isShowModal.toggle()
                                }
                            }
                        }
                        
                        Section(header:
                            HStack{
                                Text("Top rated in 2020")
                                    .font(.system(
                                        size: 28,
                                        weight: .bold,
                                        design: .default))
                                    .padding()
                                
                                Spacer()
                            }
                            .padding(0)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 0,
                                    leading: 0,
                                    bottom: 0,
                                    trailing: 0))
                                .background(Color.white)
                        ) {
                            ForEach(self.vm.topRateGame) { item in
                                GameItem(game: item)
                                    .listRowInsets(EdgeInsets())
                                    .onTapGesture {
                                        self.selectedView = .detail
                                        self.isShowModal.toggle()
                                }
                            }
                        }
                    }.listStyle(PlainListStyle())
                        .onAppear {
                            UITableView.appearance().separatorStyle = .none
                            UITableViewCell.appearance().selectionStyle = .none
                    }
                }
            }
                
                
            .navigationBarTitle("iGames")
            .navigationBarItems(trailing:
                Button(action: {
                    self.selectedView = .profile
                    self.isShowModal.toggle()
                }, label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                })
            )
        }
            
        .sheet(isPresented: self.$isShowModal) {
            if self.selectedView == .profile {
                ProfileView(isShowProfile: self.$isShowModal)
            } else {
                DetailView(game: self.selectedGame)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameItem: View {
    var game: Games
    var body: some View {
        VStack {
            WebImage(url: URL(string: game.background_image ?? ""))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(.gray)
            }
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .frame(height: 230)
            VStack(spacing: 0) {
                HStack {
                    Text((game.released?.toDate())?.getFormattedDate() ?? "-")
                        .font(.system(
                            size: 16,
                            weight: .semibold,
                            design: .default))
                        .foregroundColor(Color.black.opacity(0.30))
                        .padding(.top, 12)
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
