//
//  Photo.swift
//  Navigation
//
//  Created by Саша on 24.05.2022.
//

import UIKit

struct Photos {
    var author: String
    var image: String
    
    static func makeMockModel() -> [Photos] {
        var model = [Photos]()
        model.append(Photos(author: "Иванов", image: "01"))
        model.append(Photos(author: "Петров", image: "06"))
        model.append(Photos(author: "Сидоров", image: "11"))
        model.append(Photos(author: "Кузнецов", image: "18"))
        model.append(Photos(author: "Петренко", image: "02"))
        model.append(Photos(author: "Иваненко", image: "03"))
        model.append(Photos(author: "Сидоренко", image: "04"))
        model.append(Photos(author: "Горинов", image: "05"))
        model.append(Photos(author: "Зайцев", image: "07"))
        model.append(Photos(author: "Вербицкий", image: "08"))
        model.append(Photos(author: "Свердлов", image: "09"))
        model.append(Photos(author: "Богданов", image: "10"))
        model.append(Photos(author: "Корюков", image: "12"))
        model.append(Photos(author: "Гвоздиков", image: "13"))
        model.append(Photos(author: "Бедин", image: "14"))
        model.append(Photos(author: "Комаров", image: "15"))
        model.append(Photos(author: "Левицкий", image: "16"))
        model.append(Photos(author: "Кунцев", image: "17"))
        model.append(Photos(author: "Иванов", image: "19"))
        model.append(Photos(author: "Котов", image: "20"))
        return model
    }
}
