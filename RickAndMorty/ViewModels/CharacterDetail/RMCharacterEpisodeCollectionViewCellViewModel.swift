//
//  RMCharacterEpisodeCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 25.06.2024.
//

import Foundation

final class RMCharacterEpisodeCollectionViewCellViewModel {
    private let episodeDatUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDatUrl = episodeDataUrl
    }
}
