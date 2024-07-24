//
//  RMSearchResultViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 24.07.2024.
//

import Foundation

enum RMSearchResultViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
