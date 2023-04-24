//
//  MealTypeCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 20.04.2023.
//

import UIKit

class MealTypeCollectionViewCell: UICollectionViewCell {
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 15
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 19, weight: .medium)
        label.textColor = .black
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(label)
    }
    
    private func setupConstraints() {
        label.frame = self.bounds
    }
    
    func configureCell(mealType: String) {
        label.text = mealType.capitalized
    }
}
