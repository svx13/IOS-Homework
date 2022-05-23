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

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
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
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "Bird")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 75
        $0.layer.borderWidth = 3.0
        $0.backgroundColor = .systemGray5
        $0.contentMode = .scaleAspectFill
        $0.layer.borderColor = UIColor.white.cgColor
        return $0
    }(UIImageView())
    
    private lazy var fullNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Попугай Жора"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var statusLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Старый статус"
        $0.textColor = UIColor.gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.isUserInteractionEnabled = false
        return $0
    }(UILabel())
    
    private lazy var statusTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.indent(size: 10)
        $0.text = "Введите новый статус"
        $0.textColor = .systemGray5
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.cornerRadius = 12.0
        $0.addTarget(self, action: #selector(statusTextChanges), for: .editingChanged)
        return $0
    }(UITextField())
    
    @objc private func statusTextChanges() {
        statusText = statusTextField.text!
    }
    
    
    lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        $0.setTitle("Set status", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 10.0
        $0.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
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


