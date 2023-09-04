//
//  RecipesDetailTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 18.04.2023.
//

import UIKit
import SDWebImage

final class ImageViewTableViewCell: UITableViewCell {
    
    private lazy var receiptImageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(receiptImageView)
    }
    
    func configureReceiptCell(receiptDetailed: DetailedRecipe) {
        guard let image = receiptDetailed.image else {
            return
        }
        guard let url = URL(string: image) else {
            return
        }
        receiptImageView.sd_setImage(with: url)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                receiptImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                receiptImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                receiptImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                receiptImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
}
