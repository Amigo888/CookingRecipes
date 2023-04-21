//
//  RecipesListDetailed.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 17.04.2023.
//

import UIKit
import SDWebImage
protocol RecipesListDetaildeDisplayLogic: AnyObject {
    func displaySummaryList(viewModel: RecipesDetailedModels.FetchReceipt.ViewModel)
    func displaySummaryListFailure(viewModel: RecipesDetailedModels.FetchReceipt.ViewModelFailure)
}

class RecipesListDetailedViewController: UIViewController {
    
    enum Rows {
        static let ImageView: Int = 0
        static let DishTypes: Int = 1
        static let Title: Int = 2
        static let Ingridients: Int = 3
        static let DiffirentFields: Int = 4
        static let PairingText: Int = 5
        static let PairingMatch: Int = 6
        
    }
    
    enum Constants {
        static let numberOfRows: Int = 7
        static let HeightImageView: CGFloat = 300
        static let HeightDishestype: CGFloat = 70
        static let HeightTitle: CGFloat = 60
        static let HeightIngridient: CGFloat = 280
        static let HeightDifferentValues: CGFloat = 130
        static let HeightPairingText: CGFloat = 240
        static let HeightPairingMatches: CGFloat = 260
        static let HeightDefault: CGFloat = 0
    }
    
    var interactor: RecipesListDetailedInteractor?
    var router: ReceipeListDetaildeRouter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ImageViewTableViewCell.self, forCellReuseIdentifier: String(describing: ImageViewTableViewCell.self))
        tableView.register(MealTypesTableViewCell.self, forCellReuseIdentifier: String(describing: MealTypesTableViewCell.self))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(IngridientsTableViewCell.self, forCellReuseIdentifier: String(describing: IngridientsTableViewCell.self))
        tableView.register(DifferentValuesTableViewCell.self, forCellReuseIdentifier: String(describing: DifferentValuesTableViewCell.self))
        tableView.register(PairingTextTableViewCell.self, forCellReuseIdentifier: String(describing: PairingTextTableViewCell.self))
        tableView.register(PairingTextTableViewCell.self, forCellReuseIdentifier: String(describing: PairingMatchTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public var id: Int = 0
    
    private var summaryRecipes: DetailedRecipe?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        setupConstraints()
        fetchRecipesDetailed()
    }
    
    func setup() {
        let viewController = self
        let apiCaller = APICaller()
        let interactor = RecipesListDetailedInteractor(worker: RecipesListDetailedWorker(apiCaller: apiCaller))
        let presenter = RecipesListDetailedPresenter()
        let router = ReceipeListDetaildeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    func setupUI() {
        title = "RECIPE INSTRUCTIONS"
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func fetchRecipesDetailed() {
        interactor?.fetchDetails(response: .init(id: id))
    }
}

extension RecipesListDetailedViewController: RecipesListDetaildeDisplayLogic {
    func displaySummaryList(viewModel: RecipesDetailedModels.FetchReceipt.ViewModel) {
        let detailedRecipe = viewModel.recipeDetail
        summaryRecipes = detailedRecipe
        self.tableView.reloadData()
    }
    
    func displaySummaryListFailure(viewModel: RecipesDetailedModels.FetchReceipt.ViewModelFailure) {
        let alertController = UIAlertController(title: viewModel.errorMessage, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        view.backgroundColor = .red
        self.present(alertController, animated: true)
    }
}

extension RecipesListDetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Int(Constants.numberOfRows)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MealTypesTableViewCell.self)) as? MealTypesTableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = ""
        
        
        guard let receipt = summaryRecipes else { return cell }
        
        switch indexPath.row {
        
        case Rows.ImageView:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ImageViewTableViewCell.self)) as? ImageViewTableViewCell else { return UITableViewCell() }
            cell.configureReceiptCell(receiptDetailed: receipt)
            return cell
        
        case Rows.DishTypes:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MealTypesTableViewCell.self)) as? MealTypesTableViewCell else { return UITableViewCell() }
            cell.configure(receipeDetailed: receipt)
                return cell
        
        case Rows.Title:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self)) else { return UITableViewCell()
            }
            cell.textLabel?.text = receipt.title
            cell.textLabel?.numberOfLines = 0
            return cell
        
        case Rows.Ingridients:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngridientsTableViewCell.self)) as? IngridientsTableViewCell else { return UITableViewCell() }
            cell.configure(receipeDetailed: receipt)
            return cell
            
        case Rows.DiffirentFields:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DifferentValuesTableViewCell.self)) as? DifferentValuesTableViewCell else { return UITableViewCell() }
            cell.configure(receipeDetailed: receipt)
            cell.backgroundColor = .black
            return cell
        
        case Rows.PairingText:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PairingTextTableViewCell.self)) as? PairingTextTableViewCell else { return UITableViewCell() }
            return cell
        
        case Rows.PairingMatch:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PairingMatchTableViewCell.self)) as? PairingMatchTableViewCell else { return UITableViewCell() }
            return cell
        
        default: return UITableViewCell()
        }
    }
}
    
extension RecipesListDetailedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case Rows.ImageView:
            return Constants.HeightImageView
        case Rows.DishTypes:
            return Constants.HeightDishestype
        case Rows.Title:
            return Constants.HeightTitle
        case Rows.Ingridients:
            return Constants.HeightIngridient
        case Rows.DiffirentFields:
            return Constants.HeightDifferentValues
        case Rows.PairingText:
            return Constants.HeightPairingText
        case Rows.PairingMatch:
            return Constants.HeightPairingMatches
        default: return Constants.HeightDefault
        }
    }
}
