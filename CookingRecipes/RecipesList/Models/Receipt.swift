//
//  Receipt.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

struct ReceiptListResponse: Codable {
    let results: [Receipt]
}

// MARK: - Result
struct Receipt: Codable {
    let id: Int
    let title: String?
    let image: String?
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg = "jpg"
    case png = "png"
}

