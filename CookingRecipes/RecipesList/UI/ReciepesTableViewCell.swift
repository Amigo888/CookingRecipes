//
//  ReciepesTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

class ReciepesTableViewCell: UITableViewCell {
    
    static let identifier = "ReciepesTableViewCell"
    
    private let receiptLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let receiptImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var stackView = UIStackView()
    
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
        
        stackView = UIStackView(arrangedSubviews: [receiptImageView, receiptLabel],
                                axis: .horizontal,
                                spacing: 30,
                                distribution: .equalCentering)
        self.addSubview(stackView)
    }
    
    func configureReceiptCell(receipt: Receipt) {
        receiptLabel.text = receipt.name
        receiptImageView.image = receipt.image
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
