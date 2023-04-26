//
//  DifferentCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 20.04.2023.
//

import UIKit

class DifferentCollectionViewCell: UICollectionViewCell {
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.backgroundColor = .white
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.isEnabled = false
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
    
    func configure(info: String) {
        label.text = info
    }
}
