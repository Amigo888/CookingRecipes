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
    
    private var summaryRecipes = [DetailedRecipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        setupConstraints()
        print(id)
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
}

extension RecipesListDetailedViewController: RecipesListDetaildeDisplayLogic {
    func displaySummaryList(viewModel: RecipesDetailedModels.FetchReceipt.ViewModel) {
        <#code#>
    }
    
    func displaySummaryListFailure(viewModel: RecipesDetailedModels.FetchReceipt.ViewModelFailure) {
        <#code#>
    }
}

extension RecipesListDetailedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

extension RecipesListDetailedViewController: UITableViewDelegate {
    
}
