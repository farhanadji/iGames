//
//  Games.swift
//  iGames
//
//  Created by Farhan Adji on 17/10/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

struct Games: Decodable, Identifiable, Equatable {
    var id: Int?
    var slug: String?
    var name: String?
    var released: String?
    var background_image: String?
    var rating: Double?
    var parent_platforms: [Platforms]?
    var genres: [Genres]?
    
    static func == (lhs: Games, rhs: Games) -> Bool {
        lhs.id == rhs.id
    }
    
}
