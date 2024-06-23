# Loan Managemenet App

## Overview
This project is an iOS Developer Test where it is a simple iOS application that displays a list of loans fetched from an API. It allows the users to searc for loans, sort them alphabetically, by term, or by risk rating, and view detailed information about each loan.

## Screenshots

### Main Screen

<img src="LoanList.png" alt="Loan List Screenshot" width="280" height="608">

The screenshot above is the main screen of the Loan Management app. Here are the key elements:

1. **Navigation Bar**: The navigation bar at the top has a mint background with a white title "Loan List". 
2. **Search Bar**: Just below the navigation bar, there is a search bar where users can enter text to search for specific loans.
3. **Filter Segmented Control**: Below the search bar, there is a segmented control with three options: Alphabetical, Term, and Risk Rating. Users can tap on these to sort the list of loans.
4. **Loan List**: The list of loans is displayed below the segmented control. Each loan item shows the borrower's name, amount, interest rate, term, purpose, and risk rating.


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
