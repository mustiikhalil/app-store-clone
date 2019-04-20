//
//  VerticalStackView.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/20/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubviews.forEach { (view) in
            addArrangedSubview(view)
        }
        self.axis = .vertical
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
