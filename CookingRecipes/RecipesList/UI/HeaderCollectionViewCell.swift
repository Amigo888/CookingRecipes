//
//  HeaderCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 13.04.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    private lazy var button : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.isEnabled = false
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        addSubview(button)
    }
    
    private func setupConstraints() {
        button.frame = self.bounds
    }
    
    func configureCell(mealType: String) {
        button.setTitle(mealType, for: .normal)
    }
}
