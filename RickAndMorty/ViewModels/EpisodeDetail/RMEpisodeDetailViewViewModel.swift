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
    
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    public private(set) var cellViewModels: [SectionType] = []
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    
    //MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        //fetchEpisodeData()
    }
    
    //MARK: - Private
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        cellViewModels = [
            .information(viewModels: [
                .init(title: "E name", value: episode.name),
                .init(title: "air_date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "created", value: episode.created)
            ]),
            .characters(viewModel: characters.compactMap({ character in
                return RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageURL: URL(string: character.image)
                )
            }))
        ]
    }
    
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
                episode: episodes,
                characters: characters
            )
        }
    }
}
