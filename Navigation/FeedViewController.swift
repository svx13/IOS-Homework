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
        setupLayout()
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        firstButton.setTitle("Первая кнопка", for: .normal)
        firstButton.backgroundColor = .systemGray
        firstButton.layer.cornerRadius = 12
        firstButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return firstButton
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        self.navigationController?.pushViewController(PostViewController(), animated: true)
    }
    
    private lazy var secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setTitle("Вторая кнопка", for: .normal)
        secondButton.backgroundColor = .systemGray
        secondButton.layer.cornerRadius = 12
        secondButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return secondButton
    }()
    
    private func setupLayout() {
        view.addSubview(stackView)
        [firstButton, secondButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 110),
            firstButton.heightAnchor.constraint(equalToConstant: 50),
            secondButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

