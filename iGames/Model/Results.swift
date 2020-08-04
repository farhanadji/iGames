//
//  Results.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

struct Results: Decodable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [Games]
}
