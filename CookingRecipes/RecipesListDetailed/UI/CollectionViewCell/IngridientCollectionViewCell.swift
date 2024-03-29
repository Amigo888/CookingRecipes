//
//  IngridientCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 20.04.2023.
//

import UIKit
import SDWebImage

final class IngridientCollectionViewCell: UICollectionViewCell {
    
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
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var measureLabel: UILabel = {
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
        contentView.addSubview(measureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                ingridientImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                ingridientImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                ingridientImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                ingridientImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Constants.basicConstraint),
                
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: measureLabel.topAnchor, constant: -Constants.basicConstraint),
                
                measureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                measureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                measureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ]
        )
    }
    
    func configure(ingridient: Ingredient) {
        guard let image = ingridient.image else {
            return
        }
        let url = URLBuilder.buildURL(
            baseURL: APIConstants.URLDetail.baseURLPhoto,
            pathComponents: [APIConstants.URLDetail.pathComponentsPhoto, image],
            queryParameters: APIConstants.URLDetail.emptyQueryParameters
        )
        guard let url = url else {
            return
        }
        ingridientImageView.sd_setImage(with: url)
        
        titleLabel.text = ingridient.name.capitalized
        
        guard let amount = ingridient.measures?.metric.amount else {
            return
        }
        guard let unit = ingridient.measures?.metric.unitLong else {
            return
        }
        let measureText = "\(String(Int(amount))) \(String(unit))"
        measureLabel.text = measureText
    }
}
