//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var postModel = PostModel.makePostModel()
    private lazy var imageModel = ImageModel.addImage()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout ()
        
        self.view.backgroundColor = .systemGray6
        hideKeyboardTapperAround()
        
        
        
        navigationItem.title = "Назад"
        navigationController?.navigationBar.isHidden = false
    }
    

    private func layout () {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int {
        return postModel.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
            cell.tapPostImageDelegate = self
            cell.setupCell(postModel[indexPath.row - 1])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            cell.setupLabel("")
         
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let profileHeaderView = ProfileHeaderView()
        profileHeaderView.backgroundColor = .systemGray6
        return section == 0 ? profileHeaderView: nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 200:0
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView .deselectRow(at: indexPath, animated: true)

    }
}

extension ProfileViewController: PhotosTableViewCellDelegate {
    func buttonTap() {
        
        let photosViewController = PhotosViewController()
        navigationController?.pushViewController(photosViewController, animated: true)
    }
}


extension ProfileViewController: TapPostImageDelegate {
    func postImagePressed(author: String, description: String, image: UIImage) {
        let newView = PostDetailViewController()
        newView.authourLabel.text = author
        newView.postImageView.image = image
        newView.descriptionLable.text = description
        navigationController?.pushViewController(newView, animated: true)
    }
}


extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}


extension ProfileViewController: UITextViewDelegate {
    
    func hideKeyboardTapperAround() {
        
        let press: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        press.cancelsTouchesInView = false
        view.addGestureRecognizer(press)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}












