//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Саша on 12.05.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayuot()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private lazy var avatarImageView: UIImageView = {
        $0.image = UIImage(named: "Bird")
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 50
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.isUserInteractionEnabled = true
        return $0
    } (UIImageView())
    
    private lazy var additionalAvatar: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    
 
    private lazy var setStatusButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hexString: "#4C75A3")
        $0.setTitle("Set status", for: .normal)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.textColor = UIColor.systemRed
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.addTarget(self, action: #selector(buttonStatus), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var cancelAnimationButton: UIButton = {
        $0.layer.opacity = 0
        $0.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        $0.addTarget(self, action: #selector(pressCancelAnimationButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        return $0
    }(UIButton())
    
    private lazy var blackView: UIView = {
        $0.frame = UIScreen.main.bounds
        $0.backgroundColor = .black
        $0.alpha = 0.8
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.opacity = 0
    
        return $0
    }(UIView())
    
    private lazy var fullNameLable: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Попугай Жора"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private lazy var statusView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Старый статус"
        $0.backgroundColor = .clear
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UITextView())
    

    private var statusTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Введите новый статус"
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
        $0.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return $0
    }(UITextField())
    
    @objc private func buttonStatus() {
        if statusTextField.text == "" {
            statusTextField.attributedPlaceholder = NSAttributedString(
                string: "Не может быть пустым",
                attributes: [NSAttributedString.Key.foregroundColor:UIColor.red]
            )
        }
        guard statusTextField.text != "" else { return }
        statusView.text = statusText ?? ""
        
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    

       private func setupGestures (){
           let tapGesture = UITapGestureRecognizer (target: self, action: #selector(tapAction))
           avatarImageView.addGestureRecognizer(tapGesture)
       }
    
       @objc private func tapAction(){
           
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 1.0,
                          initialSpringVelocity: 0.0,
                          options: .curveEaseInOut) {

               
               self.avatarImageView.layer.position = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
               self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
               self.blackView.layer.opacity = 0.8
               self.avatarImageView.layer.cornerRadius = 0
               self.layoutIfNeeded()

           } completion: { _ in
               UIView.animate(withDuration: 0.3,
                              delay: 0.0) {
               self.cancelAnimationButton.layer.opacity = 1
               }
           }

       }
       
       @objc private func pressCancelAnimationButton() {
           UIView.animate(withDuration: 0.3,
                          delay: 0.0,
                          usingSpringWithDamping: 1.0,
                          initialSpringVelocity: 0.0,
                          options: .curveEaseInOut) {
               self.cancelAnimationButton.layer.opacity = 0
           } completion: { _ in
               UIView.animate(withDuration: 0.5,
                              delay: 0.0) {
                   self.blackView.layer.opacity = 0.0
                   self.avatarImageView.layer.position = self.additionalAvatar.layer.position
                   self.avatarImageView.layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
                   self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.width / 2
                   self.layoutIfNeeded()
               }
           }
       }
    
    

    private func setupLayuot (){
        [fullNameLable, statusTextField, setStatusButton, statusView, additionalAvatar, blackView, avatarImageView, cancelAnimationButton ].forEach {self.addSubview($0)}
        NSLayoutConstraint.activate([
            
           
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            additionalAvatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            additionalAvatar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            additionalAvatar.heightAnchor.constraint(equalToConstant: 100),
            additionalAvatar.widthAnchor.constraint(equalTo: additionalAvatar.heightAnchor, multiplier: 1),
            cancelAnimationButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cancelAnimationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cancelAnimationButton.widthAnchor.constraint(equalToConstant: 40),
            cancelAnimationButton.heightAnchor.constraint(equalTo: cancelAnimationButton.widthAnchor, multiplier: 1),
            fullNameLable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            fullNameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusView.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -6),
            statusView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusView.heightAnchor.constraint(equalToConstant: 30),
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16 ),
            setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

