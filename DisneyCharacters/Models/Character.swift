//
//  Character.swift
//  DisneyCharacters
//
//  Created by app-kaihatsusha on 01/06/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

struct Character: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    

}
