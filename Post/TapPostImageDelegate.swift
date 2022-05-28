//
//  TapPostImageDelegate.swift
//  Navigation
//
//  Created by Саша on 28.05.2022.
//

import UIKit

protocol TapPostImageDelegate: AnyObject {
    func postImagePressed(author: String, description: String, image: UIImage)
}
