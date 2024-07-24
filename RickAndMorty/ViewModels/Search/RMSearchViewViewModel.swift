//
//  RMSearchViewViewModel.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 14.07.2024.
//

import Foundation

// responsibilitiea
// show search results
// show no results view
// kick off api requests

final class RMSearchViewViewModel {
    let config: RMSearchViewController.Config
    
    private var searchText = ""
    
    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption:String] = [:]
    
    private var searchResultHandler: (() -> Void)?
    
    //MARK: - Init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
   
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func executeSearch() {
        // create request based on filters
        
        // build arguments
        var queryParams: [URLQueryItem] = [
            (URLQueryItem(name: "name", value: searchText.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed))
            )
        ]
        
        // add options
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        // create request
        let request = RMRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams
        )
        
        RMService.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { result in
            switch result {
            case .success(let model):
                print("search results found \(model.results.count)")
            case .failure(let failure):
                break
            }
        }
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(
        _ block: @escaping ((RMSearchInputViewViewModel.DynamicOption, String)) -> Void
    ) {
        self.optionMapUpdateBlock = block
    }
}
