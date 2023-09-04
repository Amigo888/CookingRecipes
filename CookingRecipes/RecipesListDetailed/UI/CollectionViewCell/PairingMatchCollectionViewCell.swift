//
//  PairingMatchCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 21.04.2023.
//

import UIKit

final class PairingMatchCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let basicConstraint: CGFloat = 8
    }
    
    private lazy var ingridientImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(ingridientImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                ingridientImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                ingridientImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.basicConstraint),
                ingridientImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                ingridientImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.basicConstraint),
            ]
        )
    }
    
    func configure(pairingMatches: PairingMatches) {
        guard let image = pairingMatches.imageUrl else {
            return
        }
        guard let url = URL(string: image) else {
            return
        }
        ingridientImageView.sd_setImage(with: url)
        titleLabel.text = pairingMatches.title
    }
}
