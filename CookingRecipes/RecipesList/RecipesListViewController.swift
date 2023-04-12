//
//  ViewController.swift
//  CookingRecipes
//
//  Created by Дмитрий Процак on 11.04.2023.
//

import UIKit

protocol RecipesListDisplayLogic: AnyObject {
    func displayRecipesList(viewModel: RecipesModels.FetchReceipt.ViewModel)
}

class RecipesListViewController: UIViewController {
    
    var interactor: ReceipeListBuisnessLogic?
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var receipts: [Receipt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReciepesTableViewCell.self, forCellReuseIdentifier: ReciepesTableViewCell.identifier)
        view.addSubview(tableView)
    }
    
//    private func fetchRecipesList() {
//        let request = RecipesModels.FetchReceipt.ViewModel()
//        interactor?.fetchFoods(request: request)
//    }
    
    private func setup() {
        let viewController = self
        let interactor = ReceipeListInteractor()
        let presenter = ReceipeListPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
    
    private func doSomething() {
        let request = RecipesModels.FetchReceipt.Request(receipe: <#[Receipt]#>)
        interactor?.fetchFoods(request: request)
    }
    
   
}

extension RecipesListViewController: RecipesListDisplayLogic {
    func displayRecipesList(viewModel: RecipesModels.FetchReceipt.ViewModel) {
        receipts = viewModel.recipe
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RecipesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReciepesTableViewCell.identifier, for: indexPath) as? ReciepesTableViewCell else { return UITableViewCell() }
        let receipt = receipts[indexPath.row]
        cell.configureReceiptCell(receipt: receipt)
        return cell
    }
}

extension RecipesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
