//
//  MemeTableCell.swift
//  MemePractice
//
//  Created by Administrator on 10/9/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTableCell: UITableViewCell {
    
    // MARK: Listing visible objects
    
    @IBOutlet weak var tablePic: UIImageView!
    @IBOutlet weak var tableTitle: UILabel!
    
    // MARK: Model setup
    
    func configure(with model: Meme) {
        tablePic.image = model.memedImage
        tableTitle.text = "\(model.topText)|\(model.bottomText)"
    }
}
