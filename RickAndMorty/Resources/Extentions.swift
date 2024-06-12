//
//  Extentions.swift
//  RickAndMorty
//
//  Created by Bilgehan Akyol on 12.06.2024.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views .forEach({
            addSubview($0)
        })
    }
}
