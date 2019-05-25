//
//  AppsCell.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class AppsCell: UICollectionViewCell {
    
    fileprivate let imgSize: CGFloat = 64
    
    var item: FeedResults? {
        didSet {
            guard let item = item else { return }
            nameLabel.text = item.name
            companyLabel.text = item.artistName
            appIconImageView.setImageWith(string: item.artworkUrl100)
        }
    }
    
    fileprivate lazy var appIconImageView: AppStoreImageView = {
        let imgView = AppStoreImageView(cornerRadius: 8)
        imgView.backgroundColor = .purple
        imgView.widthAnchor.constraint(equalToConstant: imgSize).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: imgSize).isActive = true
        return imgView
    }()
    
    fileprivate let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "App name with a very very long name"
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    fileprivate let companyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Photos"
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()

    fileprivate lazy var getButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(downloadAppPressed), for: .touchUpInside)
        btn.setTitle("GET", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = UIColor(white: 0.95, alpha: 1)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.widthAnchor.constraint(equalToConstant: 80).isActive = true
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let infoStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 2),
            getButton
            ])
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        addSubview(infoStackView)
        infoStackView.fillSuperView(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func downloadAppPressed() {
        
    }
    
    func clear() {
        nameLabel.text = nil
        companyLabel.text = nil
        appIconImageView.image = nil
    }
    
}
