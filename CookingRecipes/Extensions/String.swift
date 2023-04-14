//
//  String.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 14.04.2023.
//

import Foundation

extension String {
    func capitalizerFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
