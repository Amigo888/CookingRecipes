//
//  Receipt.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

struct Receipt {
    let image: UIImage
    let name: String
}

struct ImageName {
    static let pasta = "pasta"
    static let pizza = "pizza"
}

struct Source {
    static func makeContacts() -> [Receipt] {
        [
            .init(image: .init(named: ImageName.pasta)!, name: "Pizza"),
            .init(image: .init(named: ImageName.pizza)!, name: "Pasta"),
            .init(image: .init(named: ImageName.pasta)!, name: "Borsh"),
            .init(image: .init(named: ImageName.pizza)!, name: "Pelmeni"),
            .init(image: .init(named: ImageName.pasta)!, name: "Milk"),
            .init(image: .init(named: ImageName.pizza)!, name: "Garlic"),
            .init(image: .init(named: ImageName.pasta)!, name: "Cheese"),
            .init(image: .init(named: ImageName.pizza)!, name: "Sausage"),
            .init(image: .init(named: ImageName.pasta)!, name: "Varenik"),
            .init(image: .init(named: ImageName.pizza)!, name: "Pelmeni"),
        ]
    }
}
