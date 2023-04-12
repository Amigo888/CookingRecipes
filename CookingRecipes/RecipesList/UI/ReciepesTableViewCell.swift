//
//  ReciepesTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

class ReciepesTableViewCell: UITableViewCell {
    
    enum Constants {
        static let imageViewHeight: CGFloat = 70
        static let imageViewWidth: CGFloat = 70
        static let basicConstraint: CGFloat = 16
        static let labelLeading: CGFloat = 35
    }
    
    static let identifier = String(describing: ReciepesTableViewCell.self)

    
    private lazy var receiptLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var receiptImageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        receiptImageView.layer.cornerRadius = receiptImageView.frame.width / 2
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
        
        self.addSubview(receiptImageView)
        self.addSubview(receiptLabel)
        
    }
    
    func configureReceiptCell(receipt: Receipt) {
        receiptLabel.text = receipt.name
        receiptImageView.image = receipt.image
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            receiptImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.basicConstraint),
            receiptImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.basicConstraint),
            receiptImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight),
            receiptImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewWidth),
            
            receiptLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.labelLeading),
            receiptLabel.leadingAnchor.constraint(equalTo: receiptImageView.trailingAnchor, constant: Constants.basicConstraint)
        ])
    }
    
}
