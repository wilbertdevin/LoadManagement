//
//  LoanPayment.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import Foundation

struct RepaymentSchedule: Codable {
    let installments: [Installment]
}

struct Installment: Codable {
    let dueDate: String
    let amountDue: Double
}
