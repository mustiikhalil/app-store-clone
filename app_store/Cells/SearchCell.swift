//
//  SearchCell.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/20/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    fileprivate let imgSize: CGFloat = 64
    
    var item: ItunesResult? {
        didSet {
            guard let item = item else { return }
            nameLabel.text = item.trackName
            categoryLabel.text = item.primaryGenreName
            ratingLabel.text = "Rating: \(item.averageUserRating ?? 0.0)"
            
            for index in 0..<imagesStackView.arrangedSubviews.count {
                if let appImageView = imagesStackView.arrangedSubviews[index] as? AppStoreImageView, index < item.screenshotUrls.count {
                    appImageView.setImageWith(string: item.screenshotUrls[index])
                }
            }
            
            appIconImageView.setImageWith(string: item.artworkUrl100)
        }
    }
    
    fileprivate lazy var appIconImageView: AppStoreImageView = {
        let imgView = AppStoreImageView()
        imgView.widthAnchor.constraint(equalToConstant: imgSize).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: imgSize).isActive = true
        return imgView
    }()
    
    fileprivate let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "App name"
        return lbl
    }()
    
    fileprivate let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Photos"
        return lbl
    }()
    
    fileprivate let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Rating: 9.6m"
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
    
    fileprivate lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 1...3 {
            imagesStackView.addArrangedSubview(createDummyImageViews())
        }
        
        let infoStackView = UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel]),
                getButton
            ])
        
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        
        let overAllStackView = VerticalStackView(arrangedSubviews: [infoStackView, imagesStackView], spacing: 16)
        
        addSubview(overAllStackView)
        overAllStackView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func downloadAppPressed() {
        
    }
    
    func clear() {
        imagesStackView.arrangedSubviews.forEach { (view) in
            if let appImageView = view as? AppStoreImageView {
                appImageView.image = nil
            }
        }
        nameLabel.text = nil
        categoryLabel.text = nil
        ratingLabel.text = nil
        appIconImageView.image = nil
    }
    
    fileprivate func createDummyImageViews() -> AppStoreImageView {
        let imageView = AppStoreImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
}
