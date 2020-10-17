//
//  ProfileViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation
import Alamofire

class ProfileViewModel: ObservableObject {
    static let shared = ProfileViewModel()
    @Published var isSetShowPreference: Bool = false
    @Published var preference: Genres?
    @Published var genres: [Genres] = []
    @Published var selectedPreference: Int? = 0
    let userDefaults = UserDefaults.standard
    
    
    init() {
        getAllGenres() {
            self.getUserPreference()
        }
    }
    
    fileprivate func getAllGenres(completion: @escaping() -> Void) {
        if let genres = try? userDefaults.getObject(forKey: Constant.genresKey, castTo: [Genres].self) {
            self.genres = genres
        } else {
            AF.request("\(Constant.baseURL)/genres",method: .get).responseDecodable(of: ResultsGenre.self) { [self] response in
                if let genres = response.value?.results {
                    self.genres = genres
                    try? userDefaults.setObject(genres, forKey: Constant.genresKey)
                }
            }
        }
        completion()
    }
    
    func getUserPreference() {
        if let preference = try? userDefaults.getObject(forKey: Constant.preferenceKey, castTo: Genres.self) {
            self.preference = preference
            if let id = preference.id {
                let selectedId = self.genres.firstIndex { (genre) in
                    genre.id == id
                }
                self.selectedPreference = selectedId
                
            }
        }
        
    }
    
    func savePreference() {
        if let index = selectedPreference {
            let selected = self.genres.first { (genre) in
                genre.id == index
            }
            try? userDefaults.setObject(selected, forKey: Constant.preferenceKey)
            self.preference = selected
        }
        self.isSetShowPreference = false
    }
}
