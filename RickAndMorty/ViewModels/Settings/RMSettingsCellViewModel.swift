//
//  RMSettingsCellViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 3.07.2024.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    let id = UUID()
    private let type: RMSettingsOption
    
    //MARK: - Init
    
    init(type: RMSettingsOption) {
        self.type = type
    }
    
    //MARK: - Public
    
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconConteinerColor: UIColor {
        return type.iconConteinerColor
    }
}
