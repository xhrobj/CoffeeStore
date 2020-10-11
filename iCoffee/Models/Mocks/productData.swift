//
//  productData.swift
//  iCoffee
//

import Foundation
import CombineFirebase

func createMenu() {
    for product in productData {
        _ = FirebaseReference(.Menu).addDocument(from: product)
    }
}

let productData = [
    //HOT
    Product(id: UUID().uuidString, name: "Эспрессо", imageName: "espresso", category: Category.hot, description: "Эспрессо - метод приготовления кофе путём прохождения горячей воды (около 90 °C) под давлением (около 9 бар) через фильтр с молотым кофе", price: 125),
]
