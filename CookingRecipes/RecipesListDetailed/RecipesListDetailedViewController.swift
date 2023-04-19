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
    
    var interactor: RecipesListDetailedInteractor?
    var router: ReceipeListDetaildeRouter?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipesDetailTableViewCell.self, forCellReuseIdentifier: String(describing: RecipesDetailTableViewCell.self))
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
        UIView.animate(withDuration: 0.1) {
            self.tableView.reloadData()
        }
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecipesDetailTableViewCell.self), for: indexPath) as? RecipesDetailTableViewCell else { return UITableViewCell() }
        guard let receipt = summaryRecipes else { return cell }
        
        if indexPath.row == 0 {
            cell.configureReceiptCell(receiptDetailed: receipt)
        }
        if indexPath.row == 1 {
            cell.configureReceiptCell(receiptDetailed: receipt)
        }
        if indexPath.row == 2 {
            cell.configureReceiptCell(receiptDetailed: receipt)
        }
        if indexPath.row == 3 {
            cell.configureReceiptCell(receiptDetailed: receipt)
        }
        if indexPath.row == 4 {
            cell.configureReceiptCell(receiptDetailed: receipt)
        }
        return cell
    }
    
    
}

extension RecipesListDetailedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
