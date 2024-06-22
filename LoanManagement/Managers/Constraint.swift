//
//  SetupLabel.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 22/06/24.
//

import UIKit

func setupLabelConstraints(label: UILabel, contentView: UIView, topAnchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
    label.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(label)
    
    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: topAnchor, constant: constant),
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10) // Ensure it doesn't overlap the cell bottom
    ])
}


func layoutLabelsAndImageViews(labels: [UILabel], imageViews: [UIImageView], in view: UIView, padding: CGFloat) {
    var yOffset: CGFloat = 110
    
    for label in labels {
        label.frame = CGRect(x: padding, 
                             y: yOffset,
                             width: view.frame.size.width - 2 * padding,
                             height: label.sizeThatFits(CGSize(width: view.frame.size.width - 2 * padding, 
                                                               height: .greatestFiniteMagnitude)).height + 5)
        
        yOffset += label.frame.size.height + padding
    }
    
    for imageView in imageViews {
        imageView.frame = CGRect(x: padding, 
                                 y: yOffset + padding,
                                 width: 300,
                                 height: 250)
        
        yOffset += imageView.frame.size.height + padding
    }
}


