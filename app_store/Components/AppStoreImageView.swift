//
//  AppStoreImageView.swift
//  app_store
//
//  Created by Mustafa Khalil on 5/14/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class AppStoreImageView: UIImageView {
    
    static var operationQueue = OperationQueue()
    static let imageCache = NSCache<NSString, UIImage>()
    
    init(cornerRadius: CGFloat = 15) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageWith(string: String) {
        guard let url = URL(string: string) else { return }
        setImageFrom(url: url)
    }
    
    func setImageFrom(url: URL) {
        
        if let cachedImage = AppStoreImageView.imageCache.object(forKey: url.absoluteString as NSString) {
            setImage(image: cachedImage)
            return
        }
        
        let fetchOperation = Client.shared.downloadImage(url: URLRequest(url: url)) { [weak self] (operationData) in
            guard let data = operationData.data, let cachedImage = UIImage(data: data) else {
                return
            }
            AppStoreImageView.imageCache.setObject(cachedImage, forKey: url.absoluteString as NSString)
            self?.setImage(image: cachedImage)
        }
        
        AppStoreImageView.operationQueue.addOperations(fetchOperation, waitUntilFinished: false)
    }
    
    fileprivate func setImage(image: UIImage) {
        self.image = image
    }
}
