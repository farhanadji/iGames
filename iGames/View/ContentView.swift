//
//  ContentView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var isShowHeader: Bool = false
    @State var tab = "Explore"
    @State var isShowDetailHeader: Bool = false
    @ObservedObject var contentVM: ContentViewModel = .shared
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    GeometryReader { geo in
                        HStack {
                            if self.tab == "Explore" {
                                Text("Explore an \nexciting games")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.system(size: 32, weight: .bold, design: .default))
                                
                                Spacer()
                                
                                Button(action: {
                                    self.contentVM.showSearchView()
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 40, height: 40)
                                        
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(Color.white)
                                    }.fixedSize()
                                }
                            } else {
                                Spacer()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 20)
                        .onReceive(self.timer) { (_) in
                            if !self.contentVM.isShowDetail {
                                let y = geo.frame(in: .global).minY
                                if -y > 140 {
                                    self.isShowHeader = true
                                } else {
                                    self.isShowHeader = false
                                }
                            }
                        }
                    }.frame(height: tab == "Explore" ? 140 : 90)
                    
                    if tab == "Explore" {
                        HomeView()
                    } else if tab == "Favorite" {
                        FavoriteView()
                    } else {
                        ProfileView()
                    }
                }
            }
            
            if (isShowHeader || tab == "Favorite" || tab == "Account") && !self.contentVM.isShowDetail {
                CollapsedNavBar()
            }
            
            HStack(spacing: 0) {
                TabButton(title: "Explore", tab: self.$tab)
                    .padding(.leading, 10)
                Spacer(minLength: 0)
                TabButton(title: "Favorite", tab: self.$tab)
                Spacer(minLength: 0 )
                TabButton(title: "Account", tab: self.$tab)
                    .padding(.trailing, 10)
            }
            .frame(height: 70)
            .background(Color.white)
            .clipShape(Capsule())
            .padding([.leading, .trailing], 20)
            .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 20)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 0)
            
            if self.contentVM.isShowSearch {
                VStack {
                    SearchView()
                }
                .background(Color.white)
                .animation(.linear(duration: 0.2))
                .transition(.fade)
            }
            
            
            if self.contentVM.isShowDetail {
                VStack {
                    DetailView(timer: self.$timer)
                }.background(Color.white)
                .animation(.linear(duration: 0.2))
                .transition(.fade)
            }
            
        }.edgesIgnoringSafeArea([.top, .bottom])
        .onAppear {
            self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CollapsedNavBar: View {
    @ObservedObject var contentVM: ContentViewModel = .shared
    var body: some View {
        VStack
        {
            HStack(alignment: .center) {
                Text("iGames")
                    .font(.system(size: 22, weight: .bold, design: .default))
                Spacer()
                Button(action: {
                    self.contentVM.showSearchView()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.white)
                    }.fixedSize()
                    
                }
            }.padding(.horizontal)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .frame(height: 90)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 4)
            Spacer()
        }
    }
}
