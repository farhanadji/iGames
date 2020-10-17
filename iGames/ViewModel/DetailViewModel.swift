//
//  DetailViewModel.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class DetailViewModel: ObservableObject {
    @Published var gameData: Game = Game(id: 0, description_raw: "", parent_platforms: [], genres: [])
    @Published var isLoading: Bool = true
    var managedObjectContext: NSManagedObjectContext?
    
    func getGameData(id: String) {
        AF.request("\(Constant.baseURL)/games/\(id)",method: .get).responseDecodable(of: Game.self) { response in
            if let data = response.value {
                self.gameData = data
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.isLoading = false
            }
        }
    }
}
