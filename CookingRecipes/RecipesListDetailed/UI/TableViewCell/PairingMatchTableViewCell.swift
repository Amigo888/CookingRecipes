//
//  PairingMatchTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 19.04.2023.
//

import UIKit

final class PairingMatchTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let minimunLineSpacing: CGFloat = 10
        static let leftRightInsets: CGFloat = 10
        static let topBottomInsets: CGFloat = 10
        static let itemWidth: CGFloat = 160
        static let itemHeight: CGFloat = 220
    }
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        layout.itemSize = CGSize(
            width: Constants.itemWidth,
            height: Constants.itemHeight
        )
        layout.minimumLineSpacing = Constants.minimunLineSpacing
        layout.sectionInset = UIEdgeInsets(
            top: Constants.topBottomInsets,
            left: Constants.leftRightInsets,
            bottom: Constants.topBottomInsets,
            right: Constants.leftRightInsets
        )
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 10
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            PairingMatchCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: PairingMatchCollectionViewCell.self)
        )
        return collectionView
    }()
    
    private var pairingMatches = [PairingMatches]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ]
        )
    }
    
    func configure(receipeDetailed: DetailedRecipe) {
        pairingMatches = receipeDetailed.winePairing?.productMatches ?? []
        
    }
}

extension PairingMatchTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pairingMatches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PairingMatchCollectionViewCell.self), for: indexPath) as? PairingMatchCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(pairingMatches: pairingMatches[indexPath.row])
        return cell
    }
}

