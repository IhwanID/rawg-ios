//
//  GameDetail.swift
//  rawg
//
//  Created by Ihwan ID on 22/10/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

struct GameDetail: Codable {
    //required
    let id: Int?
    let name: String?
    let background_image: String?
    let released: String?
    let rating: Double?
    //non required
    let slug: String?
    let description: String?
    let tba: Bool?
    let ratings: [Ratings]?
    let ratings_count: Int?
    let reviews_text_count: Int?
    let added: Int?
    let added_by_status: AddedByStatus?
    let metacritic: Int?
    let playtime: Int?
    let suggestions_count: Int?
    let reviews_count: Int?
    let saturated_color: String?
    let dominant_color: String?
    let platforms: [Platforms]?
    let parent_platforms: [ParentPlatforms]?
    let genres: [Genres]?
    let stores: [Stores]?
    let clip: Clip?
    let tags: [Tags]?
    let short_screenshots: [ShortScreenshots]?
}

struct AddedByStatus: Codable{
    let yet: Int?
    let owned: Int?
    let beaten: Int?
    let toplay: Int?
    let dropped: Int?
    let playing: Int?
}

struct Ratings: Codable{
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}

struct Platforms: Codable{
    let platform: Platform?
    let released_at: String?
    let requirements_en: Requirement?
}

struct ParentPlatforms: Codable{
    let platform: Platform?
}

struct Platform: Codable{
    let id: Int?
    let name: String?
    let slug: String?
    let games_count: Int?
    let image_background: String?
}

struct Requirement: Codable{
    let recommended: String?
    let minimum: String?
}

struct Genres: Codable{
    let id: Int?
    let name: String?
    let slug: String?
    let games_count: Int?
    let image_background: String?
}

struct Stores: Codable{
    let store: Store?
}

struct Store: Codable{
    let id: Int?
    let name: String?
    let slug: String?
    let domain: String?
    let games_count: Int?
    let image_background: String?
}

struct Clip: Codable{
    let clip: String?
    let video: String?
}

struct Tags: Codable{
    let id: Int?
    let name: String?
    let slug: String?
    let language: String?
    let games_count: Int?
    let image_background: String?
}

struct ShortScreenshots: Codable{
    let id: Int?
    let image: String?
}
