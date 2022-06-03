//
//  Photo.swift
//  Navigation
//
//  Created by Саша on 24.05.2022.
//

import Foundation
import UIKit

struct ImageModel {
    var image: String
    
    static func addImage() -> [ImageModel] {
        var image = [ImageModel]()
        
        image.append(ImageModel(image: "01"))
        image.append(ImageModel(image: "02"))
        image.append(ImageModel(image: "03"))
        image.append(ImageModel(image: "04"))
        image.append(ImageModel(image: "05"))
        image.append(ImageModel(image: "06"))
        image.append(ImageModel(image: "07"))
        image.append(ImageModel(image: "08"))
        image.append(ImageModel(image: "09"))
        image.append(ImageModel(image: "10"))
        image.append(ImageModel(image: "11"))
        image.append(ImageModel(image: "12"))
        image.append(ImageModel(image: "13"))
        image.append(ImageModel(image: "14"))
        image.append(ImageModel(image: "15"))
        image.append(ImageModel(image: "16"))
        image.append(ImageModel(image: "17"))
        image.append(ImageModel(image: "18"))
        image.append(ImageModel(image: "19"))
        image.append(ImageModel(image: "20"))
        
        return image
    }
}
