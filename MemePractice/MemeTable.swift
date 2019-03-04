//
//  MemeTable.swift
//  MemePractice
//
//  Created by Administrator on 10/4/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTable: UITableViewController {
    
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    
    // MARK: Properties
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    // Function mapped to the + Button in the Table View Controller.
    
    @IBAction func create() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "CreatorNavigationController")
        if let navigationController = navigationController {
            navigationController.present(vc, animated: true)
        }
    }
    
    //  MARK: Delegate Info
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell", for: indexPath) as! MemeTableCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.tablePic.image = meme.memedImage
        cell.tableTitle.text = "\(meme.topText)|\(meme.bottomText)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailController") as! MemeDetailController
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Solved crash by updating to 'detailedImage', which is the pushed image variable in the Detail Controller.

        detailController.detailedImage = meme.memedImage
        if let navigationController = navigationController {
            navigationController.pushViewController(detailController, animated: true)
        }
    }
        
}
