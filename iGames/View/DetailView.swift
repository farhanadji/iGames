//
//  DetailView.swift
//  iGames
//
//  Created by Farhan Adji on 02/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Combine
import CoreData

struct DetailView: View {
    @Binding var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @ObservedObject var contentVM: ContentViewModel = .shared
    @State var isShowHeader: Bool = false
    @ObservedObject var detailVM: DetailViewModel = DetailViewModel()
    @State var isFavorite: Bool = false
    @State var isShowTicker: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var navigationBarPadding: CGFloat = 0.0
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        WebImage(url: URL(string: self.contentVM.gameImage ?? ""))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(.gray)
                            }
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .frame(height: UIScreen.main.bounds.height / 3)
                            .onReceive(self.timer) { (_) in
                                let y = geo.frame(in: .global).minY
                                if -y > 120 {
                                    withAnimation {
                                        self.isShowHeader = true
                                    }
                                } else {
                                    withAnimation {
                                        self.isShowHeader = false
                                    }
                                }
                            }
                    }
                    .frame(height: UIScreen.main.bounds.height / 3)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text((self.contentVM.gameReleased?.toDate())?.getFormattedDate() ?? "-")
                                .font(.system(
                                        size: 16,
                                        weight: .semibold,
                                        design: .default))
                                .foregroundColor(Color.black.opacity(0.3))
                            Spacer()
                            ForEach(self.detailVM.gameData.parent_platforms) { item in
                                Image(item.slug ?? "")
                                    .resizable()
                                    .frame(width: 19, height: 19)
                            }
                        }
                        HStack {
                            Text(self.contentVM.gameName ?? "-")
                                .font(.system(
                                        size: 26,
                                        weight: .bold,
                                        design: .default))
                            Spacer()
                            RatingView(rating: self.contentVM.gameRating ?? 0.0,
                                       size: 18,
                                       lineWidth: 2)
                        }.padding(.bottom, 20)
                        
                        Divider()
                        HStack {
                            Text("Genres")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(Color.black.opacity(0.3))
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(self.detailVM.gameData.genres) { genre in
                                    Text("\(genre.name ?? "")")
                                        .font(.system(size: 16, weight: .bold, design: .default))
                                        .foregroundColor(.white)
                                        .padding(.vertical, 5)
                                        .padding(.horizontal)
                                        .background(Color.black.opacity(0.6))
                                        .clipShape(Capsule())
                                }
                                Spacer(minLength: 0)
                            }
                        }
                        
                        Divider()
                        
                        if(detailVM.isLoading) {
                            ContentShimmer()
                        } else {
                            Text(self.detailVM.gameData.description_raw ?? "")
                                .font(.system(size: 16, weight: .regular, design: .default))
                                .foregroundColor(Color.black.opacity(0.8))
                                .padding(.top, 20)
                        }
                        
                        
                        
                    }.padding()
                    .background(Color.white)
                    .onAppear {
                        self.detailVM.getGameData(id: "\(self.contentVM.gameId ?? 0)")
                    }
                    Spacer()
                }
            }
            
            HStack {
                Button(action: {
                    withAnimation(.easeOut(duration: 0.25)) {
                        self.contentVM.dismissGameDetail()
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 18, height: 18)
                    }.fixedSize()
                }
                .padding(.top, self.navigationBarPadding)
                .padding(.horizontal)
                Text(self.isShowHeader ? self.contentVM.gameName ?? "iGames" : "")
                    .lineLimit(1)
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .padding(.top, self.navigationBarPadding)
                    .animation(.easeInOut)
                Spacer(minLength: 0)
                Button(action: {
                    withAnimation {
                        if isFavorite {
                            removeFromFavorite()
                        } else {
                            addToFavorite()
                        }
                        self.isFavorite.toggle()
                        self.showTicker()
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 20, height: 18)
                    }.fixedSize()
                }
                .padding(.top, self.navigationBarPadding)
                .padding(.horizontal)
            }.padding(.bottom, 10)
            .background(Color.white.opacity(self.isShowHeader ? 1 : 0))
            .clipped()
            .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 4)
            .animation(.easeInOut)
            .onAppear(perform: {
                checkRecordExists()
                if #available(iOS 14.0, *) {
                    self.navigationBarPadding = (UIApplication.shared.windows.first?.safeAreaInsets.top)!
                } else {
                    self.timer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
                    self.navigationBarPadding = (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 45
                }
            })
            
            if isShowTicker {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                            .padding()
                        if self.isFavorite {
                            Text("\(self.contentVM.gameName ?? "") saved to your favorite list!")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(Color.white)
                        } else {
                            Text("\(self.contentVM.gameName ?? "") removed from your favorite list!")
                                .font(.system(size: 14, weight: .regular, design: .default))
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                        Button(action: {
                            self.isShowTicker = false
                        }, label: {
                            Text("OK")
                                .font(.system(size: 14, weight: .semibold, design: .default))
                                .foregroundColor(Color.blue)
                                .padding()
                        })
                    }
                    .background(Color.black.opacity(0.87))
                    .cornerRadius(5)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                }
                .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 20)
                .transition(.flipFromBottom)
            }
            
        }.onDisappear {
            self.timer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    fileprivate func showTicker() {
        self.isShowTicker = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.isShowTicker = false
        }
    }
    
    fileprivate func addToFavorite() {
        let game = GamesFav(context: managedObjectContext)
        
        game.id = Int64(self.contentVM.gameId ?? 0)
        game.background_image = self.contentVM.gameImage
        game.name = self.contentVM.gameName
        game.rating = self.contentVM.gameRating ?? 0
        game.released = self.contentVM.gameReleased
        
        saveContext()
    }
    
    fileprivate func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    fileprivate func getGameFromDB() -> NSFetchRequest<GamesFav> {
        let predicate = NSPredicate(format: "id contains \(self.contentVM.gameId ?? 0)")
        let fetch = NSFetchRequest<GamesFav>(entityName: GamesFav.entity().name ?? "GameFav")
        fetch.predicate = predicate
        return fetch
    }
    
    fileprivate func isExistsOnDB() -> Bool {
        do {
            let count = try managedObjectContext.count(for: getGameFromDB())
            return count > 0
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    fileprivate func checkRecordExists() {
        if isExistsOnDB() {
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
    }
    
    fileprivate func removeFromFavorite() {
        if isFavorite && isExistsOnDB() {
            do {
                let gameObj = try self.managedObjectContext.fetch(getGameFromDB())
                if let game = gameObj.first {
                    self.managedObjectContext.delete(game)
                }
            } catch {
                print(error.localizedDescription)
            }
            saveContext()
        }
    }
}
