//
//  Games.swift
//  rawg
//
//  Created by Ihwan ID on 27/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

struct GameResponse: Codable {
    let results: [Game]
}

struct Game: Codable {
    let id: Int?
    let name: String?
    let background_image: String?
    let released: String?
    let rating: Double?
}






