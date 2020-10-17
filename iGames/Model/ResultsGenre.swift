//
//  ResultsGenre.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

struct ResultsGenre: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Genres]?
}
