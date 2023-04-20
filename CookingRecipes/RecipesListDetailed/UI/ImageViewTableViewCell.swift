//
//  RecipesDetailTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 18.04.2023.
//

import UIKit
import SDWebImage

class ImageViewTableViewCell: UITableViewCell {
    
    enum Constants {
        static let imageViewHeight: CGFloat = 70
        static let imageViewWidth: CGFloat = 90
        static let basicConstraint: CGFloat = 16
        static let labelTopBottom: CGFloat = 5
    }
    
    
    private lazy var receiptImageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(receiptImageView)
        
        
    }
    
    func configureReceiptCell(receiptDetailed: DetailedRecipe) {
        guard let url = URL(string: receiptDetailed.image!) else { return }
        receiptImageView.sd_setImage(with: url)
    }
    
    private func setConstraints() {
        receiptImageView.frame = contentView.bounds
//        NSLayoutConstraint.activate([
//            receiptImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            receiptImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            receiptImageView.trailingAnchor.constraint(equalToConstant: contentView.trailingAnchor),
//            receiptImageView.bottomAnchor.constraint(equalToConstant: contentView.bottomAnchor),
//
//        ])
    }
    
}
