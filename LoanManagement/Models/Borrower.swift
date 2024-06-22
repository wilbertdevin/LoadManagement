//
//  LoanProfile.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 21/06/24.
//

import Foundation

struct Borrower: Codable {
    let id: String
    let name: String
    let email: String
    let creditScore: Int
}
