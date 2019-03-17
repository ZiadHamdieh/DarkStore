//
//  TabBarController.swift
//  AppStore
//
//  Created by Ziad Hamdieh on 2019-03-13.
//  Copyright © 2019 Ziad Hamdieh. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            setupNavController(forViewController: AppsController(), withtitle: "Apps", imageName: "apps"),
            setupNavController(forViewController: UIViewController(), withtitle: "Today", imageName: "today"),
            setupNavController(forViewController: SearchController() , withtitle: "Search", imageName: "search")
        ]
    }
    
    fileprivate func setupNavController(forViewController viewController: UIViewController, withtitle title: String, imageName: String) -> UIViewController {
        
        let newNavController = UINavigationController(rootViewController: viewController)
        newNavController.tabBarItem.title = title
        newNavController.navigationItem.title = title
        newNavController.tabBarItem.image = UIImage(named: imageName)
        newNavController.navigationBar.prefersLargeTitles = true
        
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        return newNavController
    }
}
