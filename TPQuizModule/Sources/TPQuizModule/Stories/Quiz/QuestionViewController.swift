//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import UIKit

protocol QuestionViewControllerNavigationDelegate: AnyObject {
    func displayNextPage(fromQuestionViewController questionViewController: QuestionViewController)
}

class QuestionViewController: UIViewController {

    // MARK: - Enums
    
    enum QuestionAnswerState {
        case unanswered
        case selecting
        case answered
    }
    
    enum BottomButtonStyle {
        case confirm
        case nextQuestion
        case hidden
    }
    
    
    // MARK: - States
    
    private var questionAnswerState: QuestionAnswerState = .unanswered
    private var bottomButtonStyle: BottomButtonStyle = .nextQuestion
    
    // MARK: - Properties
    
    var viewModel: QuestionViewModel!
    weak var delegate: QuestionViewControllerNavigationDelegate?

    // MARK: - Outlets
    
    @IBOutlet private weak var questionScrollView: UIScrollView!
    @IBOutlet weak var questionsCountLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var bottomFilledButton: UIButton!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    func setup() {
        viewModel.delegate = self
        
        questionsCountLabel.text = viewModel.questionCountProgressString
        questionLabel.text = viewModel.question.questionString
        
        answerStackView.axis = .vertical
        answerStackView.alignment = .fill
        answerStackView.distribution = .fill
        answerStackView.spacing = 8
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomFilledButton.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                return outgoing
        }
        //setup answers
        let buttons = viewModel.setupAnswerButtons()
        for button in buttons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            answerStackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Actions
    
    @objc func buttonTapped(_ sender: AnswerButton) {
        if questionAnswerState == .answered { return }
        viewModel.answerSelected(button: sender)
    }
    
    @IBAction private func bottomFilledButtonnPressed(_ sender: Any) {
        if questionAnswerState == .answered {
            delegate?.displayNextPage(fromQuestionViewController: self)
        }
        if questionAnswerState == .selecting {
            viewModel.evalueateQuestion()
        }
    }
    
    // MARK: - Utilities
    
    private func toggleAnswerButton(button: AnswerButton) {
        UIView.animate(withDuration: 0.08, animations: {
            button.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            button.alpha = 0.7
        }) { (_) in
            
            button.isSelected.toggle()

            UIView.animate(withDuration: 0.08) {
                button.transform = .identity
                button.alpha = 1.0
            }
        }
    }
    
    private func animateBottonButton(show: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.bottomFilledButton.alpha = show ? 1 : 0
        }
    }
}

extension QuestionViewController: QuestionViewModelDelegate {
    func answerButtonSelected(button: AnswerButton) {
        toggleAnswerButton(button: button)
    }
    
    func updateButtomButtonStyle(style: BottomButtonStyle) {
        switch style {
        case .confirm:
            bottomFilledButton.setTitle("CONFIRM", for: .normal)
            animateBottonButton(show: true)
        case .nextQuestion:
            if viewModel.answerType == .singleCorrectAnswer { // this means the button is not presenent on screen yet, animate it
                bottomFilledButton.setTitle("NEXT QUESTION", for: .normal)
                animateBottonButton(show: true)
            }
            if viewModel.answerType == .multipleCorrectAnswers { // the button is shown from confirmation, just update title and state
                UIView.animate(withDuration: 0.1) {
                    self.bottomFilledButton.titleLabel?.alpha = 0
                } completion: { _ in
                    self.bottomFilledButton.setTitle("NEXT QUESTION", for: .normal) // normally we would propably use something like NSLocalizedString("CONFIRM_MESSAGE", comment: "")
                    UIView.animate(withDuration: 0.1) {
                        self.bottomFilledButton.titleLabel?.alpha = 1
                    }
                }
            }
        case .hidden:
            animateBottonButton(show: false)
        }
        
        self.bottomButtonStyle = style
    }
    
    func updateAnsweringStte(state: QuestionAnswerState) {
        questionAnswerState = state
    }
}
