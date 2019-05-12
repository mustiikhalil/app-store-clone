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
    
    fileprivate let searchQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "operations-search"
        return queue
    }()
    
    var result = OperationsData<SearchResults>() {
        didSet {
            guard let items = result.data?.results else { return }
            self.items = items
        }
    }
    
    var items: [ItunesResult] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        
        search(url: URLRequest(url: URL(string: "https://itunes.apple.com/search?term=instagram&entity=software")!))
        search(url: URLRequest(url: URL(string: "https://itunes.apple.com/search?term=facebook&entity=software")!))
        
    }
    
    func search(url: URLRequest) {
        searchQueue.cancelAllOperationsWithDependencies()
        let operations = Client.shared.search(url: url) { [weak self] (result) in
            self?.result = result
        }
        searchQueue.addOperations(operations, waitUntilFinished: false)
    }
    
}

// MARK: - CollectionView funcs

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 350)
    }
}
