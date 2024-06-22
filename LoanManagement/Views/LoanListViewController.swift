//
//  LoanProfileViewController.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import UIKit

class LoanListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var viewModel = LoanListViewModel()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(LoanListTableViewCell.self, forCellReuseIdentifier: LoanListTableViewCell.identifier)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Loan List"
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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
        return viewModel.loans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoanListTableViewCell.identifier, for: indexPath) as? LoanListTableViewCell else {
            fatalError("Failed to dequeue LoanListTableViewCell")
        }
        cell.configure(with: viewModel.loans[indexPath.row])
        return cell
    }

    // MARK: - TableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedLoan = viewModel.loans[indexPath.row]
        let detailVC = LoanDetailViewController(viewModel: selectedLoan)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
