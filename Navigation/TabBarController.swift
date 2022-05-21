//
//  TabBarController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let feedViewController = FeedViewController()
    let profileViewController = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    private func setupControllers(){
        
        let navController = UINavigationController(rootViewController: feedViewController)
        feedViewController.tabBarItem.title = "Лента пользователя"
        feedViewController.tabBarItem.image = UIImage(systemName: "bookmark")
        feedViewController.navigationItem.title = "Лента пользователя"
        
        let navController2 = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem.title = "Профиль пользователя"
        profileViewController.tabBarItem.image = UIImage(systemName: "mail")
        profileViewController.navigationItem.title = "Профиль пользователя"
        
        viewControllers = [navController, navController2]
    }
}
