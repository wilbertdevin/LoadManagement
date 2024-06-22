//
//  LoanListViewModel.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import Foundation

class LoanListViewModel {
    private(set) var loans: [LoanViewModel] = []
    
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
}

