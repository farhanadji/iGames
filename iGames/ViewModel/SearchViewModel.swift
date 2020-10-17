//
//  SearchViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation
import Alamofire

class SearchViewModel: ObservableObject {
    static let shared = SearchViewModel()
    @Published var isSearching: Bool = false
    @Published var isLoading: Bool = false
    @Published private(set) var searchedGame: [Games] = []
    
    func searchGame(query: String) {
        self.isSearching = true
        self.isLoading = true
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request("\(Constant.baseURL)/games?search=\(query ?? "")",method: .get).responseDecodable(of: ResultsGame.self) { response in
            if let data = response.value?.results {
                self.searchedGame = data
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.isLoading = false
            }
        }
    }
    
    func reset() {
        self.isLoading = false
        self.isSearching = false
        self.searchedGame = []
    }
}
