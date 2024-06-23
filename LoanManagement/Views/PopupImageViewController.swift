//
//  PopupImageViewController.swift
//  LoanManagement
//
//  Created by Wilbert Devin Wijaya on 23/06/24.
//

import UIKit

class PopupImageViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let backgroundView = UIView()
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        // Background view for the popup
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 12
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        // Configure imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(imageView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 380),
            backgroundView.heightAnchor.constraint(equalToConstant: 380),
        ])
        
        setupViewConstraints(view: imageView, contentView: backgroundView, topAnchor: backgroundView.topAnchor, constant: 10)

        // Add tap gesture recognizer to dismiss the popup
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        view.addGestureRecognizer(dismissTapGesture)
    }
    
    @objc private func dismissPopup() {
        dismiss(animated: true, completion: nil)
    }
}
