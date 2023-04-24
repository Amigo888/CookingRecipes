//
//  PairingTextTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 19.04.2023.
//

import UIKit

class PairingTextTableViewCell: UITableViewCell {
    
    enum Constants {
        static let topBottomConstraint: CGFloat = 16
        static let leftRightBottomConstraint: CGFloat = 16
    }
    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.isEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.topBottomConstraint),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.topBottomConstraint),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leftRightBottomConstraint),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.leftRightBottomConstraint)
        ])
    }
    
    func configure(receipeDetailed: DetailedRecipe) {
        let text = receipeDetailed.winePairing?.pairingText.isEmpty ?? false ? "Enjoy you food" : receipeDetailed.winePairing?.pairingText
        label.text = text
    }
    
}
