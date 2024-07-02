//
//  RMEpisodeDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 29.06.2024.
//

import UIKit

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl :URL?
    
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    
    private var dataTuple: (RMEpisode, [RMCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    //MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        //fetchEpisodeData()
    }
    
    //MARK: - Public
    
    //MARK: - Private
    
    /// Fetch backing episode model
    public func fetchEpisodeData() {
        guard let url = endpointUrl,
              let request = RMRequest(url: url) else {
            return
        }
        
        RMService.shared.execute(request,
                                 expecting: RMEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacters(episodes: model)
            case .failure:
                break
            }
        }
    }
    
    private func fetchRelatedCharacters(episodes: RMEpisode) {
        let requests: [RMRequest] = episodes.characters.compactMap({
            return URL(string: $0)
        }).compactMap({
            return RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                
                switch result {
                case .success(let model):
                    characters.append(model)
                default:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTuple = (
                episodes,
                characters
            )
        }
    }
}
