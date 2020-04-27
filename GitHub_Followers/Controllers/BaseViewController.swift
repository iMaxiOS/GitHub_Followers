//
//  BaseViewController.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 27.04.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .systemGreen
        viewControllers = [
            createNavigationController(title: "Search", image: UIImage(systemName: "magnifyingglass") ?? UIImage(), view: SearchVC()),
            createNavigationController(title: "Favorites List", image: UIImage(systemName: "star.fill") ?? UIImage(), view: FavoritesListVC())
            
        ]
    }
    
    private func createNavigationController(title: String, image: UIImage, view: UIViewController) -> UIViewController {
        view.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: view)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}
