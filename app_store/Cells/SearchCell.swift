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
    
    fileprivate lazy var appIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .red
        imgView.widthAnchor.constraint(equalToConstant: imgSize).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: imgSize).isActive = true
        imgView.layer.cornerRadius = 12
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
        lbl.text = "9.6m"
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
    
    lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 1...3 {
            imagesStackView.addArrangedSubview(createDummyImageViews())
        }
        
        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel])
        labelsStackView.axis = .vertical
        
        let infoStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoStackView.spacing = 12
        infoStackView.alignment = .center
        
        let overAllStackView = UIStackView(arrangedSubviews: [infoStackView, imagesStackView])
        overAllStackView.axis = .vertical
        overAllStackView.spacing = 16
        
        addSubview(overAllStackView)
        overAllStackView.fillSuperView(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func downloadAppPressed() {
        
    }
    
    fileprivate func createDummyImageViews() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }

}
