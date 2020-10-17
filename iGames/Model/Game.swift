//
//  Game.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

struct Game: Decodable {
    var id: Int?
    var description_raw: String?
    var parent_platforms: [Platforms]
    var genres: [Genres]
}
