//
//  RMSearchInputViewViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 14.07.2024.
//

import Foundation

final class RMSearchInputViewViewModel {
    private let type: RMSearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
    }
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    //MARK: - Public
    
    public var hasDynamicOption: Bool {
        switch self.type {
        case .character, .location:
            return true
        case .episode:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .location:
            return [.locationType]
        case .episode:
            return []
        }
    }
    
    public var searchBarPlaceHolderText: String {
        switch self.type {
        case .character:
            return "Character"
        case .location:
            return "Location"
        case .episode:
            return "Episode"
        }
    }
}
