//
//  OutroViewController.swift
//  Quiz
//
//  Created by Tomas Pecuch on 04/03/2024.
//

import UIKit

class QuizOutroViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: QuizOutroViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Setup

    func setup() {
        resultLabel.text = viewModel.getQuizResultsString()
        iconImageView.image = UIImage(systemName: viewModel.quiz.iconName)
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        dismiss(animated: true) 
    }
    
}
