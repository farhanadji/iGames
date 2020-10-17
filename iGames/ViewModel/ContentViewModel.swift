//
//  ContentViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

class ContentViewModel: ObservableObject {
    static let shared = ContentViewModel()
    
    @Published private(set) var isShowDetail: Bool = false
    @Published private(set) var isShowSearch: Bool = false
    
    @Published var gameId: Int? = 0
    @Published var gameImage: String? = ""
    @Published var gameName: String? = ""
    @Published var gameRating: Double? = 0.0
    @Published var gameReleased: String? = ""
    
    func showGameDetail(id: Int?, image: String?, name: String?, rating: Double?, released: String?) {
        guard let id = id else { return }
        self.gameId = id
        self.gameImage = image
        self.gameName = name
        self.gameRating = rating
        self.gameReleased = released
        self.isShowDetail = true
    }
    
    func showSearchView() {
        self.isShowSearch = true
    }
    
    func dismissSearchView() {
        self.isShowSearch.toggle()
    }
    
    func dismissGameDetail() {
        self.isShowDetail.toggle()
    }
}
