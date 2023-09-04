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
    func startLoadingState(viewModel: RecipesModels.FetchReceipt.ViewModelLoading)
}

final class RecipesListViewController: UIViewController {
    
    private enum Constants {
        enum Layout {
            static let rowHeight: CGFloat = 130
            static let headerXY: CGFloat = 0
            static let headerHeight: CGFloat = 50
            static let numberOfRows: Int = 1
            static let heightForHeaderInSection: CGFloat = 10.0
        }
        enum Text {
            static let title = "RECEIPES"
        }
    }
    
    var interactor: ReceipeListBuisnessLogic?
    var headerView: CustomHeaderView?
    var router: (ReceipeListRouterLogic & ReceipeListDataPassing)?
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        headerView = CustomHeaderView(
            frame: CGRect(
                x: Constants.Layout.headerXY,
                y: Constants.Layout.headerXY,
                width: view.bounds.width,
                height: Constants.Layout.headerHeight
            ),
            mealTypes: APIConstants.mealTypes
        )
        headerView?.delegate = self
        tableView.tableHeaderView = headerView
        tableView.register(
            ReciepesTableViewCell.self,
            forCellReuseIdentifier: String(describing: ReciepesTableViewCell.self)
        )
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
        title = Constants.Text.title
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
        NSLayoutConstraint.activate(
            [
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ]
        )
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
            self.startLoadingState(viewModel: RecipesModels.FetchReceipt.ViewModelLoading(isLoading: false))
            self.tableView.reloadData()
        }
    }
    
    func displayRecipesListFailure(viewModel: RecipesModels.FetchReceipt.ViewModelFailure) {
        let alertController = UIAlertController(title: viewModel.errorMessage, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    func startLoadingState(viewModel: RecipesModels.FetchReceipt.ViewModelLoading) {
        if viewModel.isLoading {
            receipts = []
            activityIndicator.startAnimating()
            
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension RecipesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        receipts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.Layout.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: ReciepesTableViewCell.self),
            for: indexPath
        ) as? ReciepesTableViewCell else {
            return UITableViewCell()
        }
        let receipt = receipts[indexPath.section]
        cell.backgroundColor = .white
        cell.configureReceiptCell(receipt: receipt)
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.Layout.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Layout.heightForHeaderInSection
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
            self.startLoadingState(viewModel: RecipesModels.FetchReceipt.ViewModelLoading(isLoading: true))
            self.tableView.reloadData()
        }
        interactor?.fetchFoods(request: RecipesModels.FetchReceipt.Request(typeOfMeal: title))
    }
}
