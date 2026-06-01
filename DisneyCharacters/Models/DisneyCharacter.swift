//
//  DisneyCharacter.swift
//  DisneyCharacters
//
//  Created by app-kaihatsusha on 01/06/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

struct DisneyCharacter: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var imageUrl: String?
    var films: [String]
    var tvShows: [String]
    var videoGames: [String]
    var parkAttractions: [String]
    var allies: [String]
    var enemies: [String]
    var url: String

    enum CodingKeys: CodingKey {
        case name
        case imageUrl
        case films
        case tvShows
        case videoGames
        case parkAttractions
        case allies
        case enemies
        case url
    }
    

}
