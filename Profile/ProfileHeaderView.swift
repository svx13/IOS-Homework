//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Саша on 12.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.image = UIImage(named: "Bird")
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 75
        userImage.layer.borderWidth = 3.0
        userImage.backgroundColor = .systemBackground
        userImage.contentMode = .scaleAspectFill
        userImage.layer.borderColor = UIColor.white.cgColor
        return userImage
    }()
    
    lazy var userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Попугай Жора"
        userName.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userName.textColor = .black
        return userName
    }()
    
    lazy var userStatus: UITextField = {
        let userStatus = UITextField()
        userStatus.translatesAutoresizingMaskIntoConstraints = false
        userStatus.text = "Старый статус"
        userStatus.textColor = .gray
        userStatus.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        userStatus.isUserInteractionEnabled = false
        return userStatus
    }()
    
    lazy var showStatus: UIButton = {
        let showStatus = UIButton()
        showStatus.translatesAutoresizingMaskIntoConstraints = false
        showStatus.backgroundColor = .systemBlue
        showStatus.setTitle("Show status", for: .normal)
        showStatus.setTitleColor(UIColor.white, for: .normal)
        showStatus.layer.cornerRadius = 12.0
        showStatus.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatus.layer.shadowRadius = 4.0
        showStatus.layer.shadowColor = UIColor.black.cgColor
        showStatus.layer.shadowOpacity = 0.7
        showStatus.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return showStatus
    }()
    
    @objc private func tapAction() {
        userStatus.text = "Введите статус"
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            userImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            userImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            userImage.heightAnchor.constraint(equalToConstant: 150.0),
            userImage.widthAnchor.constraint(equalToConstant: 150.0),
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16.0),
            userName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            userName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            userStatus.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 16.0),
            userStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            userStatus.bottomAnchor.constraint(equalTo: showStatus.topAnchor, constant: -64.0),
            showStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            showStatus.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 45.0),
            showStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            showStatus.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func setupView(){
        addSubview(userImage)
        addSubview(userName)
        addSubview(userStatus)
        addSubview(showStatus)
        setupLayout()
    }
}


