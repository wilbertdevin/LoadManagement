# Loan Managemenet App

## Overview
This project is an iOS Developer Test where it is a simple iOS application that displays a list of loans fetched from an API. It allows the users to searc for loans, sort them alphabetically, by term, or by risk rating, and view detailed information about each loan.

## Screenshots

## Features
- **Fetch Loans:** Retrieve loan data from a remote API.
- **Search Loans:** Filter loans by borrower name, amount, or purpose.
- **Sort Loans:** Alphabetically, by term (in months), or by risk rating.
- **MVVM Architecture:** Separation of UI (`LoanListViewController`) and business logic (`LoanListViewModel`).
- **Networking:** Uses `URLSession` for API requests and `Codable` for JSON parsing.
- **Error Handling:** Basic handling for network failures and API errors.

## Getting Started
1. Clone the repository:
2. Open `LoanManagement.xcodeproj` in Xcode.
3. Build and run the project on a simulator or a physical device.
