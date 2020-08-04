//
//  DetailViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation
import Alamofire

class DetailViewModel: ObservableObject {
    @Published var gameData: Game = Game.init(id: 0, description_raw: "")
    @Published var isLoading: Bool = true
    
    func getGameData(id: String) {
        AF.request("https://api.rawg.io/api/games/\(id)",method: .get).responseDecodable(of: Game.self) { response in
            self.gameData = response.value!
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.isLoading.toggle()
            }
        }
    }
}
