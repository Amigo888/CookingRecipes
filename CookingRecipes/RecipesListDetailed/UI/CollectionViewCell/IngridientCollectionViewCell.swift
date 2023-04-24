//
//  IngridientCollectionViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 20.04.2023.
//

import UIKit
import SDWebImage

class IngridientCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
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
        label.numberOfLines = 0
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
        ingridientImageView.addSubview(titleLabel)
        ingridientImageView.addSubview(measureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            ingridientImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            ingridientImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ingridientImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ingridientImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: ingridientImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: ingridientImageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: measureLabel.topAnchor, constant: -Constants.basicConstraint),
            
            measureLabel.bottomAnchor.constraint(equalTo: ingridientImageView.bottomAnchor),
            measureLabel.leadingAnchor.constraint(equalTo: ingridientImageView.leadingAnchor),
            measureLabel.trailingAnchor.constraint(equalTo: ingridientImageView.trailingAnchor),
            
            
        ])
    }
    
    func configure(ingridient: Ingredient) {
        guard let image = ingridient.image else { return }
        let url = URLBuilder.buildURL(baseURL: APIConstants.URLDetail.baseURLPhoto,
                                      pathComponents: [APIConstants.URLDetail.pathComponentsPhoto, image],
                                      queryParameters: APIConstants.URLDetail.emptyQueryParameters)
        guard let url = url else { return }
        ingridientImageView.sd_setImage(with: url)
        
        titleLabel.text = ingridient.name.capitalized
        
        guard let amount = ingridient.measures?.metric.amount else { return }
        guard let unit = ingridient.measures?.metric.unitLong else { return }
        let measureText = "\(String(Int(amount))) \(String(unit))"
        measureLabel.text = measureText
    }
}
