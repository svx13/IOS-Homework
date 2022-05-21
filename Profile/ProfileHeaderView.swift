//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Саша on 12.05.2022.
//

import UIKit

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}

class ProfileHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var statusText = String()
    
    private lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "Bird")
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 75
        avatarImageView.layer.borderWidth = 3.0
        avatarImageView.backgroundColor = .systemGray5
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Попугай Жора"
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.textColor = .black
        return fullNameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = "Старый статус"
        statusLabel.textColor = UIColor.gray
        statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        statusLabel.isUserInteractionEnabled = false
        return statusLabel
    }()
    
    private lazy var statusTextField: UITextField = {
        let statusTextField = UITextField()
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.indent(size: 10)
        statusTextField.text = "Введите новый статус"
        statusTextField.textColor = .systemGray5
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        statusTextField.backgroundColor = .white
        statusTextField.layer.borderWidth = 1.0
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12.0
        statusTextField.addTarget(self, action: #selector(statusTextChanges), for: .editingChanged)
        return statusTextField
    }()
    
    @objc private func statusTextChanges() {
        statusText = statusTextField.text!
    }
    
    
    lazy var setStatusButton: UIButton = {
        let setStatusButton = UIButton()
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.setTitleColor(UIColor.white, for: .normal)
        setStatusButton.layer.cornerRadius = 12.0
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4.0
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return setStatusButton
    }()
    
    @objc private func tapAction() {
        statusLabel.text = statusText
        statusTextField.text = "Введите новый статус"
        self.endEditing(true)
        
    }
    
    private func setupLayout(){
        [avatarImageView, fullNameLabel, statusLabel, setStatusButton, statusTextField].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150.0),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            statusLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -64.0),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16.0),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16.0),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8.0),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 46.0),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0)
        ])
    }
    
}


