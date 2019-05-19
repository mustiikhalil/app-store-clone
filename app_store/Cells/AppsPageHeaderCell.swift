//
//  AppsPageHeaderCell.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class AppsPageHeaderCell: UICollectionReusableView {
    
    lazy var appHorizantalController: AppsHeaderViewController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let controller = AppsHeaderViewController(layout: layout)
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appHorizantalController.view)
        appHorizantalController.view.fillSuperView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
