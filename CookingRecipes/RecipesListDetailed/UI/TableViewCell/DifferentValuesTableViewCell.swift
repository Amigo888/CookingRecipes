//
//  DifferentValuesTableViewCell.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 20.04.2023.
//

import UIKit

class DifferentValuesTableViewCell: UITableViewCell {
    
    enum Constants {
        static let minimunLineSpacing: CGFloat = 10
        static let leftRightInsets: CGFloat = 10
        static let topBottomInsets: CGFloat = 20
        static let itemWidth = 160
        static let itemHeight = 30
        static let numberOfItems = 6
    }
    
    enum Rows {
        static let Servings: Int = 0
        static let ReadyMinutes: Int = 1
        static let HealthScore: Int = 2
        static let Vegan: Int = 3
        static let Likes: Int = 4
        static let GlutenFree: Int = 5
    }
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
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
        collectionView.register(DifferentCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: DifferentCollectionViewCell.self))
        
        return collectionView
    }()
    
    private var servings = String()
    private var readyInMinutes = String()
    private var healthScore = String()
    private var vegan = Bool()
    private var likes = String()
    private var glutenFree = Bool()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func configure(receipeDetailed: DetailedRecipe) {
        servings = String(receipeDetailed.servings)
        readyInMinutes = String(receipeDetailed.readyInMinutes)
        healthScore = String(receipeDetailed.healthScore)
        vegan = receipeDetailed.vegan
        likes = String(receipeDetailed.aggregateLikes)
        glutenFree = receipeDetailed.glutenFree
    }
    
}

extension DifferentValuesTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DifferentCollectionViewCell.self), for: indexPath) as? DifferentCollectionViewCell else { return UICollectionViewCell() }
        switch indexPath.row {
        case Rows.Servings:
            let serving = "Servings: \(servings)"
            cell.configure(info: serving)
        case Rows.ReadyMinutes:
            guard let minutes = Int(readyInMinutes) else { return UICollectionViewCell() }
            let minute = minutes <= 60 ? "Time : \(minutes) min" : "Time: \(minutes / 60) h \(minutes % 60) min"
            cell.configure(info: minute)
        case Rows.HealthScore:
            let healtScores = "Health Score: \(healthScore)"
            cell.configure(info: healtScores)
        case Rows.Vegan:
            let vegans = vegan ? "Vegan: ✅" : "Vegan: ❌"
            cell.configure(info: vegans)
        case Rows.Likes:
            let like = "Likes: \(likes)"
            cell.configure(info: like)
        case Rows.GlutenFree:
            let gluten = glutenFree ? "Gluten Free: ✅" : "Gluten Free: ❌"
            cell.configure(info: gluten)
        default:
            return UICollectionViewCell()
        }
        return cell
        
    }
}

extension DifferentValuesTableViewCell: UICollectionViewDelegate {
    
}
