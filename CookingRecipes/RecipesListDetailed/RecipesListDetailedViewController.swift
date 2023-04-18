//
//  RecipesListDetailed.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import UIKit
protocol RecipesListDetaildeDisplayLogic: AnyObject {
    func displaySummaryList(viewModel: RecipesDetailedModels.FetchReceipt.ViewModel)
    func displaySummaryListFailure(viewModel: RecipesDetailedModels.FetchReceipt.ViewModelFailure)
}

class RecipesListDetailedViewController: UIViewController {
    
    var interactor: RecipesListDetailedInteractor?
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "pizza")
        //image.contentMode = .scaleToFill
        //image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var id: Int = 0
    
    private var summaryRecipes = [SummaryReceipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
        setupConstraints()
        print(id)
    }
    
    func setupUI() {
        title = "RECIPE INSTRUCTIONS"
        view.addSubview(imageView)
        view.addSubview(textLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
        ])
    }
}
