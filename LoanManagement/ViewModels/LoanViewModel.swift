//
//  LoanViewModel.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import Foundation

struct LoanViewModel {
    let id: String
    let amount: String
    let interestRate: String
    let term: String
    let purpose: String
    let riskRating: String
    let borrowerName: String
    let borrowerEmail: String
    let borrowerCreditScore: String
    let collateralType: String
    let collateralValue: String
    var documents: [String]
    let repaymentSchedule: [String]
    
    init(loan: LoanList) {
        self.id = loan.id
        self.amount = "Amount: \(loan.amount)"
        self.interestRate = "Interest Rate: \(loan.interestRate)"
        self.term = "Term: \(loan.term) months"
        self.purpose = "Purpose: \(loan.purpose)"
        self.riskRating = "Risk Rating: \(loan.riskRating)"
        self.borrowerName = loan.borrower.name
        self.borrowerEmail = "Email: \(loan.borrower.email)"
        self.borrowerCreditScore = "Credit Score: \(loan.borrower.creditScore)"
        self.collateralType = "Collateral: \(loan.collateral.type)"
        self.collateralValue = "Collateral Value: \(loan.collateral.value)"
        self.documents = loan.documents.map { $0.url }
        self.repaymentSchedule = loan.repaymentSchedule.installments.map {
            "Due Date: \($0.dueDate)\nAmount Due: \($0.amountDue)\n"
        }
    }
}
