//
//  ImageCollectionViewCell.swift
//  JournalApp
//
//  Created by Patrick Gao on 28/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        layer.cornerRadius = 5.0
    }
}
