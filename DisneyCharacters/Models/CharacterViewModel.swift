//
//  DisneyCharacters.swift
//  CharacterViewModel
//
//  Created by app-kaihatsusha on 01/06/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

@Observable
class CharacterViewModel {
    
    struct Returned: Codable {
        var info: Info
        var data: [DisneyCharacter]
    }
    
    struct Info: Codable {
        var count: Int
        var totalPages: Int
        var nextPage: String?
    }
    
    var urlString = "https://api.disneyapi.dev/character"
    var count = 0
    var characters: [DisneyCharacter] = []
    var isLoading = false
    
    func getData() async {
        
        print("🕸️ We are accessing the url \(urlString)")
        isLoading = true
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode JSON into data structure
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
        
                print("😡 JSON ERROR: Could not decode JSON data from \(urlString)")
                isLoading = false
                return
            }
            
            // Confirm data was decoded:
            print("😎 JSON returned! count: \(returned.info.count), next: \(returned.info.nextPage ?? "")")
            Task { @MainActor in
                self.count = returned.info.count
                self.urlString = returned.info.nextPage ?? ""
                self.characters = self.characters + returned.data
                isLoading = false
            }

            
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
            isLoading = false
        }
    }
    
    func loadNextIfNeeded(character: DisneyCharacter) async {
        guard let lastCharacter = characters.last else { return }
        if character.id == lastCharacter.id && urlString.hasPrefix("http") {
            print("getting data after: \(character.name)")
            await getData()
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            
            // guard for last page reached
            guard urlString.hasPrefix("http") else { return }
            
            await getData()
            // recurssion - call self until all data retrieved
            await loadAll()
        }
        
    }
}
