//
//  SubAppGroupController.swift
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

class SubAppGroupController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "sub-app-controller"
    private let bottomTopInset: CGFloat = 12
    private let spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(AppsCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = view.frame.height - (spacing * 2) - (bottomTopInset * 2)
        
        return .init(width: view.frame.width - 32, height: height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: bottomTopInset, left: 16, bottom: bottomTopInset, right: 16)
    }
}
