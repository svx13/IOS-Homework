//
//  InfoViewController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        makeButton()
    }
    private func makeButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        button.center = view.center
        button.setTitle("Нажмите кнопку", for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector (tapAction), for: .touchUpInside)
        view.addSubview(button)
    }
    @objc private func tapAction(){
        let alert = UIAlertController(title: "Свернуть окно", message: "Хотите свернуть окно?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .destructive)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
