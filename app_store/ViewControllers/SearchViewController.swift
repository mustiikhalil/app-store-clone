//
//  ViewController.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController {

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) had not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

}
