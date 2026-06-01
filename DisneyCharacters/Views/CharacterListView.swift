//
//  CharacterListView.swift
//  DisneyCharacters
//
//  Created by app-kaihatsusha on 01/06/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//  API: https://api.disneyapi.dev/character

import SwiftUI

struct CharacterListView: View {
    
    @State private var characters = Characters()
    
    var body: some View {
        NavigationStack {
            List(characters.charactersArray) { character in
                Text(character.name)
            }
        }
        .task {
            await characters.getData()
        }
    }
}

#Preview {
    CharacterListView()
}
