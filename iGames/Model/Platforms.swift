//
//  Platforms.swift
//  iGames
//
//  Created by Farhan Adji on 03/08/20.
//  Copyright © 2020 Farhan Adji. All rights reserved.
//

import Foundation

struct Platforms : Identifiable {
    var id: Int?
    var name: String?
    var slug: String?
    
    enum CodingKeys: String, CodingKey {
        case platform
    }
    
    enum PlatformKeys: String, CodingKey {
        case id
        case name
        case slug
    }
}

extension Platforms: Decodable {
    init(from decoder: Decoder) throws {
        
        // Extract the top-level values ("user")
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Extract the user object as a nested container
        let platform = try values.nestedContainer(keyedBy: PlatformKeys.self, forKey: .platform)
        
        // Extract each property from the nested container
        id = try platform.decode(Int.self, forKey: .id)
        name = try platform.decode(String.self, forKey: .name)
        slug = try platform.decode(String.self, forKey: .slug)
    }
}

//
//struct Platform: Codable {
//    var id: Int?
//    var name: String?
//    var slug: String?
//}
