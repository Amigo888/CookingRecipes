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
    static let person = "person"
    static let fillPerson = "person.fill"
}

struct Source {
    static func makeContacts() -> [Receipt] {
        [
            .init(image: .init(systemName: ImageName.person)!, name: "Pizza"),
            .init(image: .init(systemName: ImageName.fillPerson)!, name: "Pasta"),
            .init(image: .init(systemName: ImageName.person)!, name: "Borsh"),
            .init(image: .init(systemName: ImageName.fillPerson)!, name: "Pelmeni"),
            .init(image: .init(systemName: ImageName.person)!, name: "Milk"),
            .init(image: .init(systemName: ImageName.fillPerson)!, name: "Garlic"),
            .init(image: .init(systemName: ImageName.person)!, name: "Cheese"),
            .init(image: .init(systemName: ImageName.fillPerson)!, name: "Sausage"),
            .init(image: .init(systemName: ImageName.person)!, name: "Varenik"),
            .init(image: .init(systemName: ImageName.fillPerson)!, name: "Pelmeni"),
        ]
    }
}
