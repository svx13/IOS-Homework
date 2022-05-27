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

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupGestures()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var statusText = String()
    private lazy var avatarImagePosition = avatarImageView.layer.position
    private lazy var avatarImageBounds = avatarImageView.layer.bounds
    
    private lazy var avatarView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .black
        $0.isUserInteractionEnabled = false
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    private lazy var avatarImageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "Bird")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 65
        $0.layer.borderWidth = 3.0
        $0.backgroundColor = .systemGray5
        $0.contentMode = .scaleAspectFill
        $0.layer.borderColor = UIColor.white.cgColor
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    private lazy var closeAvatarImageButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "multiply.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))?.withTintColor(colorSet, renderingMode: .alwaysOriginal), for: .normal)
        $0.alpha = 0.0
        $0.clipsToBounds = false
        $0.addTarget(self, action: #selector(closeAvatarAction), for: .touchUpInside)
        $0.isUserInteractionEnabled = false
        return $0
    }(UIButton())
    
    
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
    
    private lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = colorSet
        $0.setTitle("Set status", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return $0
    }(UIButton())
    
    @objc private func buttonAction() {
        statusLabel.text = statusText
        statusTextField.text = ""
        self.endEditing(true)
    }
    
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
        $0.delegate = self
        $0.addTarget(self, action: #selector(statusTextChanges), for: .editingChanged)
        return $0
    }(UITextField())
    
    @objc private func statusTextChanges() {
        statusText = statusTextField.text!
    
    }
    
    private func setupGestures() {
        let tapAvatarGesture = UITapGestureRecognizer(target: self, action: #selector(tapAvatarAction))
        avatarImageView.addGestureRecognizer(tapAvatarGesture)
    }
    
    @objc func tapAvatarAction() {
        
        self.avatarImagePosition = self.avatarImageView.layer.position
        self.avatarImageBounds = self.avatarImageView.layer.bounds
        
        UIImageView.animate(withDuration: 0.5,
                            animations: {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX, y: (UIScreen.main.bounds.midY - ProfileViewController.tableView.contentOffset.y))
            self.avatarView.alpha = 0.8
            self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.layer.borderWidth = 0
            self.avatarImageView.isUserInteractionEnabled = false
            self.setStatusButton.isUserInteractionEnabled = false
            self.statusTextField.isUserInteractionEnabled = false
            ProfileViewController.tableView.isScrollEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = false
            ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = false
        },
                            completion: { _ in
            UIImageView.animate(withDuration: 0.3) {
                self.closeAvatarImageButton.alpha = 1
                self.closeAvatarImageButton.isUserInteractionEnabled = true
                self.layoutIfNeeded()
            }
        })
        
    }
    
    @objc private func closeAvatarAction() {
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseInOut) {
            self.closeAvatarImageButton.alpha = 0
            self.closeAvatarImageButton.isUserInteractionEnabled = false
        } completion: { _ in
            UIView.animate(withDuration: 0.5,
                           delay: 0.0) {
                self.avatarView.alpha = 0.0
                self.avatarImageView.layer.position = self.avatarImagePosition
                self.avatarImageView.layer.bounds = self.avatarImageBounds
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.width / 2
                self.avatarImageView.layer.borderWidth = 3
                self.avatarImageView.isUserInteractionEnabled = true
                self.setStatusButton.isUserInteractionEnabled = true
                self.statusTextField.isUserInteractionEnabled = true
                ProfileViewController.tableView.isScrollEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 0))?.isUserInteractionEnabled = true
                ProfileViewController.tableView.cellForRow(at: IndexPath(item: 0, section: 1))?.isUserInteractionEnabled = true
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setupLayout(){
        [fullNameLabel, statusLabel, setStatusButton, statusTextField, avatarView, avatarImageView,  closeAvatarImageButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            avatarView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            avatarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 130.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 130.0),
            
            closeAvatarImageButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            closeAvatarImageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            
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
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 1.0),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}


