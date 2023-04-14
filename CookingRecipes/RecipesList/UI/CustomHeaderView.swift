//
//  CustomHeaderView.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 13.04.2023.
//

import UIKit

protocol CustoHeaderViewDelegate {
    func didSelectItem(_ title: String)
}

class CustomHeaderView: UIView {
    
    enum Constants {
        static let minimunLineSpacing: CGFloat = 10
        static let leftRightInsets: CGFloat = 10
        static let topBottomInsets: CGFloat = 0
        static let itemWidth = 120
        static let itemHeight = 30
    }
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        layout.minimumLineSpacing = Constants.minimunLineSpacing
        layout.sectionInset = UIEdgeInsets(top: Constants.topBottomInsets,
                                           left: Constants.leftRightInsets,
                                           bottom: Constants.topBottomInsets,
                                           right: Constants.leftRightInsets)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HeaderCollectionViewCell.self))
        
        return collectionView
    }()
    
    private var mealTypes: [String] = [String]()
    
    var delegate: CustoHeaderViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(collectionView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect ,mealTypes: [String]) {
        self.mealTypes = mealTypes
        super.init(frame: frame)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
    }
}

extension CustomHeaderView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealTypes.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCollectionViewCell.self), for: indexPath) as? HeaderCollectionViewCell else { return UICollectionViewCell() }
        let mealType = mealTypes[indexPath.row].capitalized
        cell.configureCell(mealType: mealType)
        return cell
    }
    
    
}
extension CustomHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = mealTypes[indexPath.row]
        delegate?.didSelectItem(item)
    }
}

