//
//  LoanDetailViewController.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import UIKit

class LoanDetailViewController: UIViewController {
    
    private let viewModel: LoanViewModel
    private let baseURL = Request.Constants.baseUrl
    
    // Define labels and image views as properties

    private let borrowerNameLabel = UILabel()
    private let borrowerEmailLabel = UILabel()
    private let borrowerCreditScoreLabel = UILabel()
    private let collateralTypeLabel = UILabel()
    private let collateralValueLabel = UILabel()
    private let documentsLabel = UILabel()
    private let repaymentText = UILabel()
    private let repaymentScheduleLabel = UILabel()
    
    // Image views for displaying document images
    private var documentImageViews: [UIImageView] = []
    
    init(viewModel: LoanViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Loan Details"
        setupLabels()
    }
    
    private func setupLabels() {
        borrowerNameLabel.text = "Borrower Name: \(viewModel.borrowerName)"
        borrowerEmailLabel.text = viewModel.borrowerEmail
        borrowerCreditScoreLabel.text = viewModel.borrowerCreditScore
        collateralTypeLabel.text = viewModel.collateralType
        collateralValueLabel.text = viewModel.collateralValue
        repaymentScheduleLabel.text = viewModel.repaymentSchedule.joined(separator: "\n")

        // Bold attributed string for "Repayment Schedule: "
        let boldTextRepayment = "\nRepayment Schedule: "
        let attributedStringRepayment = NSMutableAttributedString(string: boldTextRepayment)
        attributedStringRepayment.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: repaymentText.font.pointSize), range: NSRange(location: 0, length: boldTextRepayment.count))
        repaymentText.attributedText = attributedStringRepayment

        // Bold attributed string for "Documents: "
        let boldTextDocuments = "Documents: "
        let attributedStringDocuments = NSMutableAttributedString(string: boldTextDocuments)
        attributedStringDocuments.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: documentsLabel.font.pointSize), range: NSRange(location: 0, length: boldTextDocuments.count))
        documentsLabel.attributedText = attributedStringDocuments

        
        // Add labels to the view
        let labels = [borrowerNameLabel, borrowerEmailLabel, borrowerCreditScoreLabel, collateralTypeLabel, collateralValueLabel, repaymentText, repaymentScheduleLabel, documentsLabel]
        
        labels.forEach { label in
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            view.addSubview(label)
        }
        
        // Create image views for documents
        viewModel.documents.forEach { documentURL in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.backgroundColor = .systemBackground // Placeholder color
            view.addSubview(imageView)
            documentImageViews.append(imageView)
        }
        
        // Layout labels and image views using utility function
        layoutLabelsAndImageViews(labels: labels, imageViews: documentImageViews, in: view, padding: 10)
        
        // Load images from URLs
        loadDocumentImages()
    }
    
    private func loadDocumentImages() {
        for (index, documentURL) in viewModel.documents.enumerated() {
            guard let url = URL(string: baseURL + documentURL) else {
                continue
            }
            
            // Fetch image from URL asynchronously
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error fetching image: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid image data")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.documentImageViews[index].image = image
                }
            }.resume()
        }
    }
}



