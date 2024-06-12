//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 11.06.2024.
//

import UIKit

/// Controller to show and search for Locations
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        let request = RMRequest(
            endpoint: .character
        )
        print(request.url)
    }

}
