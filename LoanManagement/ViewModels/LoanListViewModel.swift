//
//  LoanListViewModel.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import Foundation

class LoanListViewModel {
    private(set) var loans: [LoanViewModel] = []
    private(set) var filteredLoans: [LoanViewModel] = []
    var isFiltering: Bool = false
    
    func fetchLoans(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Request(endpoint: .loans)
        Service.shared.execute(request, expecting: [LoanList].self) { [weak self] result in
            switch result {
            case .success(let loans):
                self?.loans = loans.map { LoanViewModel(loan: $0) }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchLoans(with query: String) {
            guard !query.isEmpty else {
                filteredLoans = loans
                isFiltering = false
                return
            }
            
            filteredLoans = loans.filter { loan in
                loan.borrowerName.lowercased().contains(query.lowercased()) ||
                loan.amount.lowercased().contains(query.lowercased()) ||
                loan.purpose.lowercased().contains(query.lowercased())
            }
            isFiltering = true
        }
    
}

