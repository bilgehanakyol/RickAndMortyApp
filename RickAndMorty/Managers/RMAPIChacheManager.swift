//
//  RMAPIChacheManager.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 29.06.2024.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPIChacheManager {
    // API URL: data
    
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    
    private var cache = NSCache<NSString, NSData>()

    init() {
        setUpChache()
    }
    
    //MARK: - Public
    
    public func cachedResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetChache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetChache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) {
        guard let targetChache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetChache.setObject(data as NSData, forKey: key)
    }
    //MARK: - Private
    
    private func setUpChache() {
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
    
}
