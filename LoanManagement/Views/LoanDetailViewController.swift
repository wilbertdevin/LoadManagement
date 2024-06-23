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

    private let borrowerNameLabel = UILabel()
    private let borrowerEmailLabel = UILabel()
    private let borrowerCreditScoreLabel = UILabel()
    private let collateralTypeLabel = UILabel()
    private let collateralValueLabel = UILabel()
    private let documentsLabel = UILabel()
    private let noDocumentsLabel = UILabel()
    private let repaymentText = UILabel()
    private let repaymentScheduleLabel = UILabel()
    
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

        // Bold font for "Repayment Schedule: "
        let boldTextRepayment = "\nRepayment Schedule: "
        let attributedStringRepayment = NSMutableAttributedString(string: boldTextRepayment)
        attributedStringRepayment.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: repaymentText.font.pointSize), range: NSRange(location: 0, length: boldTextRepayment.count))
        repaymentText.attributedText = attributedStringRepayment

        // Bold font for "Documents: "
        let boldTextDocuments = "Documents: "
        let attributedStringDocuments = NSMutableAttributedString(string: boldTextDocuments)
        attributedStringDocuments.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: documentsLabel.font.pointSize), range: NSRange(location: 0, length: boldTextDocuments.count))
        documentsLabel.attributedText = attributedStringDocuments

        // No documents label
        noDocumentsLabel.text = "No Document Available"
        noDocumentsLabel.textAlignment = .center
        noDocumentsLabel.isHidden = true
        
        // Add labels to the view
        let labels = [borrowerNameLabel, borrowerEmailLabel, borrowerCreditScoreLabel, collateralTypeLabel, collateralValueLabel, repaymentText, repaymentScheduleLabel, documentsLabel, noDocumentsLabel]
        
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
        
        // Layout labels and image views
        layoutLabelsAndImageViews(labels: labels, imageViews: documentImageViews, in: view, padding: 10)
        
        // Load images from URLs
        loadDocumentImages()
    }

    private func loadDocumentImages() {
            guard !viewModel.documents.isEmpty else {
                noDocumentsLabel.isHidden = false
                return
            }

            var validDocumentsCount = 0
            
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
                        let imageView = self?.documentImageViews[index]
                        imageView?.image = image
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self?.imageTapped(_:)))
                        imageView?.isUserInteractionEnabled = true
                        imageView?.addGestureRecognizer(tapGesture)
                        validDocumentsCount += 1
                        
                        // Hide the "No Document Available" label if there's at least one valid document
                        if validDocumentsCount > 0 {
                            self?.noDocumentsLabel.isHidden = true
                        }
                    }
                }.resume()
            }
            
            // Show "No Document Available" label if no valid documents found
            if validDocumentsCount == 0 {
                DispatchQueue.main.async {
                    self.noDocumentsLabel.isHidden = false
                }
            }
        }

    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView, let image = imageView.image {
            let popupVC = PopupImageViewController(image: image)
            popupVC.modalPresentationStyle = .overCurrentContext
            popupVC.modalTransitionStyle = .crossDissolve
            present(popupVC, animated: true, completion: nil)
        }
    }
}
