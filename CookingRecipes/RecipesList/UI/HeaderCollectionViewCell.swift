//
//  HeaderCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 13.04.2023.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.borderWidth =  1
        label.layer.borderColor = UIColor.black.cgColor
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.backgroundColor = .black
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
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        label.frame = self.bounds
    }
    
    func configureCell(mealType: String) {
        label.text = mealType
    }
}
