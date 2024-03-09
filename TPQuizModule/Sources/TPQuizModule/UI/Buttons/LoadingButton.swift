//
//  LoadingButton.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import UIKit

// Used to show loading indication during asynchronous calls
class LoadingButton: UIButton {

    // MARK: - Properties
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var buttonIconPlaceholder: UIImage?

    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(loadingIndicator)
        // center the loading indicator within the button
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Public
    
    func startLoading() {
        buttonIconPlaceholder = image(for: .normal)
        setImage(nil, for: .normal)
        titleLabel?.isHidden = true
        loadingIndicator.startAnimating()
        isEnabled = false
    }

    func stopLoading() {
        setImage(buttonIconPlaceholder, for: .normal)
        titleLabel?.isHidden = false
        loadingIndicator.stopAnimating()
        isEnabled = true
    }
}
