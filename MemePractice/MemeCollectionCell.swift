//
//  MemeCollectionCell.swift
//  MemePractice
//
//  Created by Administrator on 10/8/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionCell: UICollectionViewCell {
    
    // Code should be similar to Table Cell.  Listing only the imageView, as cells only include the image as a thumbnail.
    
    @IBOutlet weak var collectPic: UIImageView!
    
    func configure(with model: Meme) {
        collectPic.image = model.memedImage
    }
    
}
