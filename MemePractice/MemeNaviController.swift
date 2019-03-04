//
//  MemeNaviController.swift
//  MemePractice
//
//  Created by Administrator on 10/9/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeNaviController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createButton))
    }
    
    @objc func createButton() {
        if let navigationController = navigationController {
            navigationController.present(MemeCreatorController(), animated: true, completion: nil)
        }
    }
}
