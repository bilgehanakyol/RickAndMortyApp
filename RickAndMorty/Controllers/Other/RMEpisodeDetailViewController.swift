//
//  RMEpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 27.06.2024.
//

import UIKit
/// VC to show details about single episodes
final class RMEpisodeDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewViewModel
    
    //MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemYellow
    }
    
}
