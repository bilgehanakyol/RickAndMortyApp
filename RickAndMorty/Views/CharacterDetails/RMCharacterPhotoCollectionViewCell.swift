//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 25.06.2024.
//

import UIKit

final  class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "RMCharacterPhotoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with vireModel: RMCharacterPhotoCollectionViewCellViewModel) {
        
    }
    
}
