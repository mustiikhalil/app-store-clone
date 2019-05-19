//
//  BaseTabBarController.swift
//  app_store
//
//  Created by Mustafa Khalil on 4/20/19.
//  Copyright © 2019 Mustafa Khalil. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple
        UINavigationBar.appearance().prefersLargeTitles = true
        
        viewControllers = [
            createController(AppsViewController(layout: UICollectionViewFlowLayout()), title: "Apps", imageName: "apps"),
            createController(SearchViewController(layout: UICollectionViewFlowLayout()), title: "Search", imageName: "search"),
            createController(TodayViewController(), title: "Today", imageName: "today_icon"),
        ]
    }
    
    func createController(_ controller: UIViewController, title: String, imageName: String) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.badgeColor = .purple
        controller.navigationItem.title = title
        navigationController.tabBarItem.title = title
        return navigationController
    }
}
