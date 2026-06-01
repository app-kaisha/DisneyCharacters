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
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.title2)
                        Text(movieOrTVShow(character: character))
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }
                    .task {
                        await characterVM.loadNextIfNeeded(character: character)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Disney Characters:")
                
                if characterVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Button("Download", systemImage: "tray.and.arrow.down.fill") {
                        Task {
                            await characterVM.loadAll()
                        }
                    }
                    HStack {
                        Spacer()
                        Text("\(characterVM.characters.count) characters returned")
                        Spacer()
                    }
                }
            }
        }
        
        .task {
            await characterVM.getData()
        }
    }
    
    func movieOrTVShow(character: DisneyCharacter) -> String {
//        if !character.films.isEmpty {
//            return character.films[0]
//        }
//        
//        if !character.tvShows.isEmpty {
//            return character.tvShows[0]
//        }
//        
//        return ""
        return character.films.first ?? character.tvShows.first ?? ""
    }
}

#Preview {
    CharacterListView()
}
