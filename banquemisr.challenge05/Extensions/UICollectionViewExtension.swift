//
//  UICollectionViewExtension.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_: Cell.Type) {
        register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }

    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }
}
