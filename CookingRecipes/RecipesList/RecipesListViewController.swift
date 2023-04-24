//
//  ViewController.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

protocol RecipesListDisplayLogic: AnyObject {
    func displayRecipesList(viewModel: RecipesModels.FetchReceipt.ViewModel)
    func displayRecipesListFailure(viewModel: RecipesModels.FetchReceipt.ViewModelFailure)
}

class RecipesListViewController: UIViewController {
    
    enum Constants {
        static let rowHeight: CGFloat = 130
        static let headerXY: CGFloat = 0
        static let headerHeight: CGFloat = 50
        static let numberOfRows: Int = 1
    }
    
    var interactor: ReceipeListBuisnessLogic?
    var headerView: CustomHeaderView?
    var router: (ReceipeListRouterLogic & ReceipeListDataPassing)?
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        headerView = CustomHeaderView(frame: CGRect(x: Constants.headerXY,
                                                    y: Constants.headerXY,
                                                    width: view.bounds.width,
                                                    height: Constants.headerHeight),
                                      mealTypes: APIConstants.mealTypes)
        headerView?.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(ReciepesTableViewCell.self, forCellReuseIdentifier: String(describing: ReciepesTableViewCell.self))
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .darkGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private var receipts: [Receipt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        setupConstraints()
        fetchRecipesList()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func setupUI() {
        title = "RECEIPES"
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setup() {
        let viewController = self
        let apiCaller = APICaller()
        let interactor = ReceipeListInteractor(worker: ReceipeListWorker(apiCaller: apiCaller))
        let presenter = ReceipeListPresenter()
        let router = ReceipeListRouter()
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func fetchRecipesList() {
        interactor?.fetchFoods(request: .init(typeOfMeal: "main course"))
    }
    
}

extension RecipesListViewController: RecipesListDisplayLogic {
    func displayRecipesList(viewModel: RecipesModels.FetchReceipt.ViewModel) {
        let receipt = viewModel.recipe
        receipts = receipt
        UIView.animate(withDuration: 0.1) {
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func displayRecipesListFailure(viewModel: RecipesModels.FetchReceipt.ViewModelFailure) {
        let alertController = UIAlertController(title: viewModel.errorMessage, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
}

extension RecipesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        receipts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReciepesTableViewCell.self), for: indexPath) as? ReciepesTableViewCell else { return UITableViewCell() }
        let receipt = receipts[indexPath.section]
        cell.backgroundColor = .white
        cell.configureReceiptCell(receipt: receipt)
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let receipesId = receipts[indexPath.section].id
        router?.dataStoreId = receipesId
        router?.navigateToNextScreen()
    }
}

extension RecipesListViewController: CustoHeaderViewDelegate {
    func didSelectItem(_ title: String) {
        UIView.animate(withDuration: 0.1) {
            self.receipts = []
            self.tableView.reloadData()
            self.activityIndicator.startAnimating()
        }
        interactor?.fetchFoods(request: RecipesModels.FetchReceipt.Request(typeOfMeal: title))
    }
}
