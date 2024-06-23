//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 14.06.2024.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
}
