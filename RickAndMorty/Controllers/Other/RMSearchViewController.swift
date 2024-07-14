//
//  RMSearchViewController.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 1.07.2024.
//

import UIKit

//Dynamic search option view
//render results
//render no results zero state
//searching / api call

/// Configurable controller to search
final class RMSearchViewController: UIViewController {
    ///Configuration for search session
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode // name
            case location// name | type
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .episode:
                    return "Search Episodess"
                case .location:
                    return "Search Locations"
                }
            }
        }
        
        let type: `Type`
    }
    
    private let config: Config
    
    // MARK: - Init
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = config.type.title
        view.backgroundColor = .systemBackground
    }
    
}
