//
//  LoanProfileViewController.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import UIKit

class LoanListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = Request(endpoint: .loans)
        Service.shared.execute(request, expecting: [LoanList].self) { result in
            switch result {
            case .success(let loans):
                for loan in loans {
                    print("Loan ID: \(loan.id)")
                    print("Amount: \(loan.amount)")
                    print("Interest Rate: \(loan.interestRate)")
                    print("Term: \(loan.term)")
                    print("Purpose: \(loan.purpose)")
                    print("Risk Rating: \(loan.riskRating)")
                    print("Borrower Name: \(loan.borrower.name)")
                    print("Borrower Email: \(loan.borrower.email)")
                    print("Borrower Credit Score: \(loan.borrower.creditScore)")
                    print("Collateral Type: \(loan.collateral.type)")
                    print("Collateral Value: \(loan.collateral.value)")
                    print("Documents:")
                    for document in loan.documents {
                        print(" - Type: \(document.type), URL: \(document.url)")
                    }
                    print("Repayment Schedule:")
                    for installment in loan.repaymentSchedule.installments {
                        print(" - Due Date: \(installment.dueDate), Amount Due: \(installment.amountDue)")
                    }
                    print("---")
                }
            case .failure(let error):
                print("Failed to fetch loan data: \(error)")
            }
        }
    }
    

}
