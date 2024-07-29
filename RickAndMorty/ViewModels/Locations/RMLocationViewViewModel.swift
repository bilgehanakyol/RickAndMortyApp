//
//  RMLocationViewViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 9.07.2024.
//

import Foundation

protocol RMLocationViewViewModelDelegate: AnyObject {
    func didFetchInitialLocations()
}

final class RMLocationViewViewModel {
    
    weak var delegate: RMLocationViewViewModelDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    //location response info
    //will contain next url, if present
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    
    public private(set) var cellViewModels: [RMLocationTableViewCellViewModel] = []
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public var isLoadingMoreLocations = false
    
    private var didFinishPagination: (() -> Void)?
    
    //MARK: Init
    
    init() {}
    
    public func registerDidFinishPaginationBlock(_ block:  @escaping () -> Void) {
        self.didFinishPagination = block
    }
    
    //paginate if additional locations are needed
    public func fetchAdditionalLocations() {
        //fetch locations
        guard !isLoadingMoreLocations else {
            return
        }
        
        guard let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreLocations = true
        
        print("fetching more characters")
        guard let request = RMRequest(url: url) else {
            isLoadingMoreLocations = false
            print("failed to create request")
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({
                    return RMLocationTableViewCellViewModel(location: $0)
                }))
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreLocations = false
                    
                    // notify via callback
                    strongSelf.didFinishPagination?()
                }
                
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreLocations = false
            }
        }
    }
    
    public func location(at index: Int) -> RMLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    public func fetchLocaitons() {
        RMService.shared.execute(
            .listLocaitonRequests,
            expecting: RMGetAllLocationsResponse.self
        ){ [ weak self ] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocations()
                }
            case .failure(let error):
                //TODO: error handling
                break
            }
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
