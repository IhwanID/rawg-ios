//
//  Games.swift
//  rawg
//
//  Created by Ihwan ID on 27/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

struct GamesResponse: Codable {
    let results: [Games]
}

struct Games: Codable {
    let id: Int
    let name: String?
    let rating: Double
    let released: String
    let background_image: String
    
//    private enum CodingKeys: String, CodingKey{
//        case id, name, rating, released, background_image
//    }
}
