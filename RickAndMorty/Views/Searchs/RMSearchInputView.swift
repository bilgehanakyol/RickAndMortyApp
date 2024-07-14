//
//  RMSearchInputView.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 14.07.2024.
//

import UIKit

final class RMSearchInputView: UIView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: RMSearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOption else {
                return
            }
            
            let options = viewModel.options
            createOptionSelectionView(options: viewModel.options)
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemCyan
        addSubViews(searchBar)
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func createOptionSelectionView(options: [RMSearchInputViewViewModel.DynamicOption]) {
        for option in options {
            
        }
    }
    
    public func configure(with viewModel: RMSearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchBarPlaceHolderText
        // TODO: fix height of input for episode screen with no option
        self.viewModel = viewModel
    }
}
