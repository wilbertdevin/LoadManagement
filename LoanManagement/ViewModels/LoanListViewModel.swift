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
    
    private var isAscendingOrderByAlphabetical: Bool = true
    private var isAscendingOrderByTerm: Bool = true
    private var isAscendingOrderByRiskRating: Bool = true
    
    // MARK: - Fetch API
    
    func fetchLoans(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = Request(endpoint: .loans)
        Service.shared.execute(request, expecting: [LoanList].self) { [weak self] result in
            switch result {
            case .success(let loans):
                self?.loans = loans.map { LoanViewModel(loan: $0) }
                self?.filteredLoans = self?.loans ?? []
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Search Feature
    
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
    
    // MARK: - SortBy Feature

    func sortByAlphabeticalOrder() {
        if isAscendingOrderByAlphabetical {
            loans.sort { $0.borrowerName < $1.borrowerName }
            filteredLoans.sort { $0.borrowerName < $1.borrowerName }
        } else {
            loans.sort { $0.borrowerName > $1.borrowerName }
            filteredLoans.sort { $0.borrowerName > $1.borrowerName }
        }
        isAscendingOrderByAlphabetical.toggle()
    }
    
    func sortByTermOrder() {
        if isAscendingOrderByTerm {
            loans.sort { $0.term < $1.term }
            filteredLoans.sort { $0.term < $1.term }
        } else {
            loans.sort { $0.term > $1.term }
            filteredLoans.sort { $0.term > $1.term }
        }
        isAscendingOrderByTerm.toggle()
    }

    func sortByRiskRatingOrder() {
        if isAscendingOrderByRiskRating {
            loans.sort { $0.riskRating < $1.riskRating }
            filteredLoans.sort { $0.riskRating < $1.riskRating }
        } else {
            loans.sort { $0.riskRating > $1.riskRating }
            filteredLoans.sort { $0.riskRating > $1.riskRating }
        }
        isAscendingOrderByRiskRating.toggle()
    }

}

