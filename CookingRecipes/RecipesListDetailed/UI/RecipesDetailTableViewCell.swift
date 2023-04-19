//
//  RecipesDetailTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 18.04.2023.
//

import UIKit
import SDWebImage

class RecipesDetailTableViewCell: UITableViewCell {
    
    enum Constants {
        static let imageViewHeight: CGFloat = 70
        static let imageViewWidth: CGFloat = 90
        static let basicConstraint: CGFloat = 16
        static let labelTopBottom: CGFloat = 5
    }
    
    static let identifier = String(describing: ReciepesTableViewCell.self)
    
    private lazy var receiptLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var receiptImageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiptImageView.layer.cornerRadius = 20
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
        contentView.addSubview(receiptLabel)
        
        
    }
    
    func configureReceiptCell(receiptDetailed: DetailedRecipe) {
        receiptLabel.text = receiptDetailed.title
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            receiptImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.basicConstraint),
            receiptImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.basicConstraint),
            receiptImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            receiptImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
            
            receiptLabel.centerYAnchor.constraint(equalTo: receiptImageView.centerYAnchor),
            receiptLabel.leadingAnchor.constraint(equalTo: receiptImageView.trailingAnchor, constant: Constants.basicConstraint),
            contentView.trailingAnchor.constraint(equalTo: receiptLabel.trailingAnchor, constant: Constants.basicConstraint),
            receiptLabel.heightAnchor.constraint(equalToConstant: 100)
            
            
        ])
    }
    
}
