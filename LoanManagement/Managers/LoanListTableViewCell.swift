//
//  LoanListTableViewCell.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import UIKit

class LoanListTableViewCell: UITableViewCell {
    static let identifier = "LoanListTableViewCell"
    
    private let amountLabel = UILabel()
    private let interestRateLabel = UILabel()
    private let termLabel = UILabel()
    private let purposeLabel = UILabel()
    private let riskRatingLabel = UILabel()
    private let borrowerNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLabels()
        addLabelsToContentView()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: LoanViewModel) {
        amountLabel.text = viewModel.amount
        interestRateLabel.text = viewModel.interestRate
        termLabel.text = viewModel.term
        purposeLabel.text = viewModel.purpose
        riskRatingLabel.text = viewModel.riskRating
        
        // Set borrowerName label with bold text
        let borrowerNameAttributedString = NSMutableAttributedString(string: viewModel.borrowerName)
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: borrowerNameLabel.font.pointSize)]
        borrowerNameAttributedString.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: viewModel.borrowerName.count))
        borrowerNameLabel.attributedText = borrowerNameAttributedString
        
    }
    
    private func configureLabels() {
        [amountLabel, interestRateLabel, termLabel, purposeLabel, riskRatingLabel, borrowerNameLabel].forEach {
            $0.numberOfLines = 0
        }
    }
    
    private func addLabelsToContentView() {
        contentView.addSubview(amountLabel)
        contentView.addSubview(interestRateLabel)
        contentView.addSubview(termLabel)
        contentView.addSubview(purposeLabel)
        contentView.addSubview(riskRatingLabel)
        contentView.addSubview(borrowerNameLabel)
    }
    
    private func applyConstraints() {
        let labels = [borrowerNameLabel, amountLabel, interestRateLabel, termLabel, purposeLabel, riskRatingLabel]
        
        var previousLabel: UILabel?
        
        for label in labels {
            if let previous = previousLabel {
                setupLabelConstraints(label: label, contentView: contentView, topAnchor: previous.bottomAnchor, constant: 10)
            } else {
                setupLabelConstraints(label: label, contentView: contentView, topAnchor: contentView.topAnchor, constant: 15)
            }
            previousLabel = label
        }
        
        // Ensure last label doesn't overlap the cell bottom
        if let lastLabel = labels.last {
            NSLayoutConstraint.activate([
                lastLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -15)
            ])
        }
    }
}





