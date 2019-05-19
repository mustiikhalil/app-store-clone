//
//  UICollectionViewController.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UICollectionViewController {
    
    convenience init(layout: UICollectionViewFlowLayout) {
        self.init(collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white
    }
}
