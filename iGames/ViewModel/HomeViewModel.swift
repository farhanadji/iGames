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
    @Published var isLoadingList: Bool = true
    
    init() {
        self.getMovieList()
        self.getTopRated()
    }
    
    func getMovieList(){
        AF.request("https://api.rawg.io/api/games",method: .get).responseDecodable(of: Results.self) { response in
            guard let games = response.value?.results else { return }
            self.popularGame = games
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.isLoadingList.toggle()
            }
        }
    }
    
    func getTopRated(){
        AF.request("https://api.rawg.io/api/games", method: .get, parameters: ["dates": "2020-01-01,2020-12-31", "ordering": "-rating"]).responseDecodable(of: Results.self) { response in
            guard let games = response.value?.results else { return }
            self.topRateGame = games
        }
    }
}
