//
//  MemeDetailController.swift
//  MemePractice
//
//  Created by Administrator on 10/8/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailController: UIViewController {
    
    // MARK: Listing visible assets
    
    @IBOutlet weak var galleryMeme: UIImageView!
    
    // MARK: Properties
    
    // Setting up the pushed image.  Since this controller has no access to the array index, the correct image will be pushed by the Table/Collection controllers.
    
    var detailedImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.galleryMeme.image = detailedImage
    }
    
    
}
