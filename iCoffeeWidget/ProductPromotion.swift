//
//  ProductPromotion.swift
//  iCoffeeWidget
//

import Foundation

struct ProductPromotion: Codable, Equatable, Hashable {
    var name: String
    var imageName: String
    var oldPrice: Double
    var price: Double
}

let productPromotionMock = ProductPromotion(
    name: "-",
    imageName: "espresso",
    oldPrice: 0,
    price: 0
)
