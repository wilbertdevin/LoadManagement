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
        searchBar.placeholder = "Search..."
        return searchBar
    }()

    private lazy var filterSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Alphabetical", "Term", "Risk Rating"])
        segmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        segmentedControl.addTarget(self, action: #selector(filterSegmentChanged(_:)), for: .valueChanged)
        segmentedControl.isMomentary = true

        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Loan List"
        
        // Customize navigation bar appearance
            if let navBar = navigationController?.navigationBar {
                let appearance = UINavigationBarAppearance()
                
                appearance.backgroundColor =  UIColor.systemMint
                
                let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                appearance.titleTextAttributes = titleTextAttributes
                
                navBar.standardAppearance = appearance
                navBar.scrollEdgeAppearance = appearance
            }
        
        setupSearchBar()
        setupTableView()
        setupFilterSegmentedControl()
        
        fetchData()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)

    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, 
                                                         y: 0,
                                                         width: view.bounds.width,
                                                         height: 0.1))
    }
    
    private func setupFilterSegmentedControl() {
        view.addSubview(filterSegmentedControl)
        filterSegmentedControl.addTarget(self, action: #selector(filterSegmentChanged(_:)), for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchBar.frame = CGRect(x: 0, 
                                 y: view.safeAreaInsets.top,
                                 width: view.bounds.width,
                                 height: 50)
        
        filterSegmentedControl.frame = CGRect(x: 20, 
                                              y: searchBar.frame.maxY + 10,
                                              width: view.bounds.width - 40,
                                              height: 30)
        
        tableView.frame = CGRect(x: 0, 
                                 y: filterSegmentedControl.frame.maxY + 10,
                                 width: view.bounds.width,
                                 height: view.bounds.height - filterSegmentedControl.frame.maxY - 10)
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
    
    // MARK: - Sorting
    
    @objc private func filterSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.sortByAlphabeticalOrder()

        case 1:
            viewModel.sortByTermOrder()
            
        case 2:
            viewModel.sortByRiskRatingOrder()
            
        default:
            break
        }
        tableView.reloadData()
        
        // Deselect the segment after action
        sender.selectedSegmentIndex = UISegmentedControl.noSegment

    }
}
