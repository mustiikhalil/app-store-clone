//
//  AppsViewController.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/20/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class AppsPageViewController: UICollectionViewController {
    
    private let heightCell: CGFloat = 300
    private let cellId = "apps-view-controller-cell"
    private let headerId = "apps-view-controller-header"
    private let operationQueue: OperationQueue = {
        let opQueue = OperationQueue()
        opQueue.maxConcurrentOperationCount = 5
        opQueue.name = "apps-page-view-operationqueue"
        return opQueue
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activity)
        activity.fillSuperView()
        return activity
    }()
    
    var refreshOperation = UpdateUIOperation()
    var orderedGroup = AppsPageViewModel.create()
    var groups: [AppsPageViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .yellow
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        setupUI()
        orderedGroup
            .forEach { (viewModel) in
                self.fetchData(appPageViewModel: viewModel)
            }
    }
    
    func setupUI() {
        activityIndicator.startAnimating()
        refreshOperation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshView()
            }
        }
    }
    
    func refreshView() {
        groups = orderedGroup.filter { $0.appGroup != nil }
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
}

// MARK: - Collection view functions

extension AppsPageViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeaderCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        cell.item = groups[indexPath.item].appGroup?.feed
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.width, height: 0)
    }
    
}

// MARK: - Networking calls

extension AppsPageViewController {
    
    func fetchData(appPageViewModel: AppsPageViewModel) {
        let operations = Client.shared.fetchData(url: Client.shared.rssFeedUrl(type: appPageViewModel.modelType.id)) { [weak self]  (result: Result<AppGroup, Error>) in
            self?.setupItems(appPageViewModel: appPageViewModel, result: result)
        }
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        guard let operation = operations.last else { return }
        operation >>> refreshOperation
        if !operationQueue.operations.contains(refreshOperation) {
            operationQueue.addOperation(refreshOperation)
        }
    }
    
    func setupItems(appPageViewModel: AppsPageViewModel, result: Result<AppGroup, Error>) {
        switch result {
        case .failure(let error):
            print(error)
            
        case .success(let appGroup):
            appPageViewModel.appGroup = appGroup
        }
    }
    
}
