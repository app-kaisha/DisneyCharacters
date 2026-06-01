//
//  CharacterListView.swift
//  DisneyCharacters
//
//  Created by app-kaihatsusha on 01/06/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//  API: https://api.disneyapi.dev/character

import SwiftUI

struct CharacterListView: View {
    
    @State private var characterVM = CharacterViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(characterVM.characters) { character in
                    Text(character.name)
                }
                .font(.title2)
                .listStyle(.plain)
                .navigationTitle("Disney Characters")
                
                if characterVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
            }
        }
        .task {
            await characterVM.getData()
        }
    }
}

#Preview {
    CharacterListView()
}
