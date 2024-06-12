//
//  RMEndpoint.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 11.06.2024.
//

import Foundation
/// Represents uniqe API endpoint
@frozen enum RMEndpoint: String {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
