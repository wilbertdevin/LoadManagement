//
//  LoanProfileViewController.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import UIKit

class LoanListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private var viewModel = LoanListViewModel()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LoanListTableViewCell.self, forCellReuseIdentifier: LoanListTableViewCell.identifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return table
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Name"
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Loan List"
        
        // Add search bar as table view header
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        if let headerView = tableView.tableHeaderView {
            let newSize = headerView.systemLayoutSizeFitting(CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height))
            headerView.frame.size.height = newSize.height
        }
    }

    private func fetchData() {
        viewModel.fetchLoans { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch loan data: \(error)")
            }
        }
    }

    // MARK: - TableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isFiltering ? viewModel.filteredLoans.count : viewModel.loans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoanListTableViewCell.identifier, for: indexPath) as? LoanListTableViewCell else {
            fatalError("Failed to dequeue LoanListTableViewCell")
        }
        let loan = viewModel.isFiltering ? viewModel.filteredLoans[indexPath.row] : viewModel.loans[indexPath.row]
        cell.configure(with: loan)
        return cell
    }

    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLoan = viewModel.isFiltering ? viewModel.filteredLoans[indexPath.row] : viewModel.loans[indexPath.row]
        let detailVC = LoanDetailViewController(viewModel: selectedLoan)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchLoans(with: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.searchLoans(with: "")
        tableView.reloadData()
    }
}
