//
//  MealTypesTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 19.04.2023.
//

import UIKit

final class MealTypesTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let minimunLineSpacing: CGFloat = 10
        static let leftRightInsets: CGFloat = 10
        static let topBottomInsets: CGFloat = 10
        static let itemWidth: CGFloat = 120
        static let itemHeight: CGFloat = 30
    }
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
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
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            MealTypeCollectionViewCell.self,
            forCellWithReuseIdentifier: String(describing: MealTypeCollectionViewCell.self)
        )
        
        return collectionView
    }()
    
    private var mealTypes = [String]()
    
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
                collectionView.topAnchor.constraint(equalTo: self.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
        )
        
    }
    
    func configure(receipeDetailed: DetailedRecipe) {
        mealTypes = receipeDetailed.dishTypes
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension MealTypesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MealTypeCollectionViewCell.self),
            for: indexPath
        ) as? MealTypeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let mealType = mealTypes[indexPath.row]
        cell.configureCell(mealType: mealType)
        return cell
    }
}
