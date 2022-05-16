//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Саша on 05.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeader = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileHeader)
        view.backgroundColor = .systemGray5
        profileHeader.backgroundColor = .lightGray
    }
    
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        profileHeader.frame = self.view.safeAreaLayoutGuide.layoutFrame
    }
    
}
