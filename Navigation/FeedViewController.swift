//
//  FeedViewController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let postOne = Post(title: "Привет")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        makeButton()
    }
    
    private func makeButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        button.center = view.center
        button.setTitle("Кнопка", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc private func tapAction(){
        let postViewController = PostViewController()
        postViewController.post = postOne
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
