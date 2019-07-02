//
//  ViewController.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/19/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit
import iTunesClient

class SearchViewController: UICollectionViewController {

    fileprivate let cellId = "search-cell-id"
    
    fileprivate let searchQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "operations-search"
        return queue
    }()
    
    var items: [ItunesResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.text = "Please enter a search term"
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.addSubview(enterSearchTermLabel)
        
        enterSearchTermLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        enterSearchTermLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 100).isActive = true
        // Do any additional setup after loading the view.
        setupSearchBar()
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func search(url: URLRequest) {
        searchQueue.cancelAllOperationsWithDependencies()
        let operations = Client.shared.search(url: url) { [weak self] (result: Result<SearchResults, Error>) in
            self?.handleResultsFetched(result: result)
        }
        searchQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func handleResultsFetched(result: Result<SearchResults, Error>) {
        
        switch result {
        case .failure(let err):
            print(err)
            
        case .success(let searchResults):
            items = searchResults.results
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty, searchText != "" else { return }
        
        if let url = URL(string: "https://itunes.apple.com/search?term=\(searchText)&entity=software") {
            search(url: URLRequest(url: url))
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        items = []
        collectionView.reloadData()
    }
    
}

// MARK: - CollectionView funcs

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.item = items[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCell
        cell.clear()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = items.count != 0
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 350)
    }
    
}

// MARK: - UI setup

extension SearchViewController {

    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}
