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
        label.text = """
                     Soy-and-Ginger-Glazed Salmon with Udon Noodles is a main course that serves 4. For <b>$5.91 per serving</b>, this recipe <b>covers 47%</b> of your daily requirements of vitamins and minerals. One portion of this dish contains approximately <b>48g of protein</b>, <b>17g of fat</b>, and a total of <b>552 calories</b>. This recipe from Food and Wine has 1 fans. If you have ginger, soy sauce, sugar, and a few other ingredients on hand, you can make it. From preparation to the plate, this recipe takes
                     """
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var id: Int?
    
    private var summaryRecipes = [SummaryReceipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
        setupConstraints()
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
