//
//  AppsGroupCell.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    var item: Feed? {
        didSet {
            guard let feed = item else { return }
            titleLabel.text = feed.title
            appGroupController.items = feed.results
        }
    }
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "App section"
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    lazy var appGroupController: SubAppGroupController = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let controller = SubAppGroupController(layout: layout)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(appGroupController.view)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            appGroupController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            appGroupController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            appGroupController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            appGroupController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
