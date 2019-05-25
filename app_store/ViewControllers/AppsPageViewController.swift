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
                guard let self = self else { return }
                self.groups = self.orderedGroup.filter { $0.appGroup != nil }
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            }
        }
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
        let operations = Client.shared.fetchData(url: Client.shared.rssFeedUrl(type: appPageViewModel.modelType.id)) { [weak self] (data: OperationsData<AppGroup>) in
            self?.setupItems(appPageViewModel: appPageViewModel, withItem: data)
        }
        operationQueue.addOperations(operations, waitUntilFinished: false)
        
        guard let operation = operations.last else { return }
        operation >>> refreshOperation
        if !operationQueue.operations.contains(refreshOperation) {
            operationQueue.addOperation(refreshOperation)
        }
    }
    
    func setupItems(appPageViewModel: AppsPageViewModel, withItem item: OperationsData<AppGroup>) {
        if let error = item.error {
            print(error)
            return
        }
        guard let appGroup = item.data else { return }
        appPageViewModel.appGroup = appGroup
    }
    
}
