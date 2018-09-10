//
//  FilterCollectionViewCell.swift
//  Neonsight
//
//  Created by Max Surgai on 10.09.2018.
//  Copyright © 2018 Max Surgai. All rights reserved.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    public var filter: Filter! {
        didSet {
            imageView.image = filter.image
            nameLabel.text = filter.name
        }
    }
}
