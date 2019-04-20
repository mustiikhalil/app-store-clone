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
            createController(SearchViewController(), title: "Search", imageName: "search"),
            createController(TodayViewController(), title: "Today", imageName: "today_icon"),
            createController(AppsViewController(), title: "Apps", imageName: "apps"),
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
