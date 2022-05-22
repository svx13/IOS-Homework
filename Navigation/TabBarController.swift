//
//  TabBarController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//


extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

import UIKit

class TabBarController: UITabBarController {
    
    let feedViewController = FeedViewController()
    let logInViewController = LogInViewController()
    let colorSet = UIColor(hex:0x4885CC)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.tintColor = UIColor(ciColor: .init(color: colorSet))
        setupControllers()
    }
    
    private func setupControllers(){
        
        let navController = UINavigationController(rootViewController: feedViewController)
        feedViewController.tabBarItem.title = "Лента пользователя"
        feedViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        feedViewController.navigationItem.title = "Лента пользователя"
        
        let navController2 = UINavigationController(rootViewController: logInViewController)
        logInViewController.tabBarItem.title = "Профиль пользователя"
        logInViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        logInViewController.navigationItem.title = "Профиль пользователя"
        
        viewControllers = [navController, navController2]
    }
}


