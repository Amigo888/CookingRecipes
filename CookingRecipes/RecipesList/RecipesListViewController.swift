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
        static let rowHeight: CGFloat = 100
        static let headerXY: CGFloat = 0
        static let headerHeight: CGFloat = 50
    }
    
    var interactor: ReceipeListBuisnessLogic?
    var headerView: CustomHeaderView?
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
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
    
    private var receipts: [Receipt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        fetchRecipesList()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    private func setupUI() {
        title = "RECEIPES"
        view.addSubview(tableView)
    }
    
    private func setup() {
        let viewController = self
        let interactor = ReceipeListInteractor(worker: ReceipeListWorker())
        let presenter = ReceipeListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func fetchRecipesList() {
        interactor?.fetchFoods(request: .init())
    }
    
}

extension RecipesListViewController: RecipesListDisplayLogic {
    func displayRecipesList(viewModel: RecipesModels.FetchReceipt.ViewModel) {
        let receipt = viewModel.recipe
        receipts = receipt
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func displayRecipesListFailure(viewModel: RecipesModels.FetchReceipt.ViewModelFailure) {
        let alertController = UIAlertController(title: viewModel.errorMessage, message: "", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        view.backgroundColor = .red
        self.present(alertController, animated: true)
    }
    
}

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReciepesTableViewCell.self), for: indexPath) as? ReciepesTableViewCell else { return UITableViewCell() }
        let receipt = receipts[indexPath.row]
        cell.configureReceiptCell(receipt: receipt)
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }
}

extension RecipesListViewController: CustoHeaderViewDelegate {
    func getTitle(title: String) {
        print(title)
    }
}
