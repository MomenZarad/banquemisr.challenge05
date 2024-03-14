//
//  MovieCollectionViewCell.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 14/03/2024.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    func setupCell() {
        containerView.setUpShadow(cornerRadius: 15, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.1)
    }
}
