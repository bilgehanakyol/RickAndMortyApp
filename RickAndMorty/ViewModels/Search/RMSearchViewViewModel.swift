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
    
    //MARK: - Init
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    //MARK: - Public
   
    public func executeSearch() {
        // create request based on filtes
        //send api call
        //nıtify view of results, no results, no error
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
