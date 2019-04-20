//
//  UIView+Anchors.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/20/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UIView {
    
    @discardableResult
    func anchor(leading: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = AnchoredConstraints()
        
        if let leading = leading {
            anchors.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let top = top {
            anchors.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let trailing = trailing {
            anchors.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if let bottom = bottom {
            anchors.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if size.width != 0 {
            anchors.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        if size.height != 0 {
            anchors.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        anchors.toArray().forEach { $0?.isActive = true }
        
        return anchors
    }
    
    func fillSuperView(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let topSuperView = superview?.topAnchor {
            topAnchor.constraint(equalTo: topSuperView, constant: padding.top).isActive = true
        }
        
        if let leadingSuperView = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: leadingSuperView, constant: padding.left).isActive = true
        }
        
        if let trailingSuperView = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: trailingSuperView, constant: -padding.right).isActive = true
        }
        
        if let bottomSuperView = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: bottomSuperView, constant: -padding.bottom).isActive = true
        }
    }
    
    func centerInSuperView(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerXSuperView = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
        
        if let centerYSuperView = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerXSuperView = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: centerXSuperView).isActive = true
        }
    }
    
    func centerYSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerYSuperView = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerYSuperView).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    
    func toArray() -> [NSLayoutConstraint?] {
        return [ top, leading, bottom, trailing, width, height ]
    }
}
