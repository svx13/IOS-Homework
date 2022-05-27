//
//  PostViewController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

struct Post{
    var title: String
}
class PostViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            title = post.title
        }
        view.backgroundColor = .cyan
        makeBarItem()
    }
    private func makeBarItem(){
        let barItem = UIBarButtonItem(title: "Следующий шаг", style: .plain, target:self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = barItem
    }
    @objc private func tapAction(){
        let infoViewController = InfoViewController()
        infoViewController.title = "Новый лист"
        present(infoViewController, animated: true)
    }
}

