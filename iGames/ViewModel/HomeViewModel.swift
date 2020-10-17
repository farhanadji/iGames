//
//  HomeViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation
import Alamofire
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var popularGame: [Games] = []
    @Published var topRateGame: [Games] = []
    @Published var preferenceGame: [Games] = []
    @Published var isLoadingList: Bool = true
    @Published private var genres: [Genres] = []
    
    static let shared = HomeViewModel()
    init() {
        self.getMovieList()
        self.getTopRated()
        self.getAllGenres() {
            self.getPreferencesGame()
        }
    }
    
    let userDefaults = UserDefaults.standard
    
    func getMovieList(){
        AF.request("\(Constant.baseURL)/games",method: .get).responseDecodable(of: ResultsGame.self) { response in
            guard let games = response.value?.results else { return }
            self.popularGame = games
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.isLoadingList.toggle()
            }
        }
    }
    
    func getTopRated(){
        AF.request("\(Constant.baseURL)/games", method: .get, parameters: ["dates": "2020-01-01,2020-12-31", "ordering": "-rating"]).responseDecodable(of: ResultsGame.self) { response in
            guard let games = response.value?.results else { return }
            self.topRateGame = games
        }
    }
    
    fileprivate func getAllGenres(completion: @escaping() -> Void) {
        if let genres = try? userDefaults.getObject(forKey: Constant.genresKey, castTo: [Genres].self) {
            self.genres = genres
        } else {
            AF.request("\(Constant.baseURL)/genres",method: .get).responseDecodable(of: ResultsGenre.self) { response in
                if let genres = response.value?.results {
                    self.genres = genres
                }
            }
        }
        completion()
    }
    
    func getPreferencesGame() {
        var keyword = ""
        if let preference = try? userDefaults.getObject(forKey: Constant.preferenceKey, castTo: Genres.self) {
            keyword = preference.slug ?? ""
        } else {
            if let pickRandom = genres.randomElement() {
                keyword = pickRandom.slug ?? ""
            }
        }
        
        AF.request("\(Constant.baseURL)/games?genres=\(keyword)",method: .get).responseDecodable(of: ResultsGame.self) { response in
            if let data = response.value?.results {
                self.preferenceGame = data
            }
        }
    }
}
