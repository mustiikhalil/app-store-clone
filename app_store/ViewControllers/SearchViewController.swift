//
//  ViewController.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController {

    fileprivate let cellId = "search-cell-id"
    fileprivate let operationsQueue = OperationQueue()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) had not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        // Do any additional setup after loading the view.
        let urlRequest = URLRequest(url: URL(string: "https://itunes.apple.com/search?term=instagram&entity=software")!)
        let networkData = OperationsData<Data>()
        let result = OperationsData<SearchResults>()
        let delayOperation = DelayOperation(delay: .now() + .seconds(5))
        let fetchOperation = FetchOperation(with: urlRequest, result: networkData)
        let decodeOpration = DecodeOperation(data: networkData, result: result)
        
        delayOperation >>> fetchOperation
        fetchOperation >>> decodeOpration
        
        decodeOpration.completionBlock = {
            print(decodeOpration.result.data?.results.count)
        }
        
        operationsQueue.addOperations([delayOperation, fetchOperation, decodeOpration], waitUntilFinished: false)
        
    }
    
}

// MARK: - CollectionView funcs

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 350)
    }
}
