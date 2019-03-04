//
//  MemeCollection.swift
//  MemePractice
//
//  Created by Administrator on 10/4/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeCollection: UICollectionViewController {
    
    // MARK: Listing visible objects (flowLayout allows the format adjustment of cells)
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // List format adjustment lines here.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
        
        let space: CGFloat = 3.0
        let size = self.view.frame.size
        var dWidth = (size.width - (3 * space)) / 3.0
        var dHeight = (size.height - (3 * space)) / 4.0
        
        if size.width > size.height {
            dWidth = (size.width - (3 * space)) / 5.0
            dHeight = (size.height - (3 * space)) / 2.0
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dWidth, height: dHeight)
    }
    
    // MARK: Properties
    
    // Should be similar to Table View
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    @IBAction func create() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "CreatorNavigationController")
        if let navigationController = navigationController {
            navigationController.present(vc, animated: true)
            vc.hidesBottomBarWhenPushed = true
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.collectPic.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailController
        let meme = self.memes[(indexPath as NSIndexPath).row]
        detailController.detailedImage = meme.memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}
