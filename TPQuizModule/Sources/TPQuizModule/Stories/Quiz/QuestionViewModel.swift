//
//  QuestionViewModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 06/03/2024.
//

import Foundation

// QuestionViewController observes this viewModel events to update its state and animate changes
protocol QuestionViewModelDelegate: AnyObject {
    func answerButtonSelected(button: AnswerButton)
    func updateButtomButtonStyle(style: QuestionViewController.BottomButtonStyle)
    func updateAnsweringStte(state: QuestionViewController.QuestionAnswerState)
}

class QuestionViewModel: NSObject {
    
    // MARK: - Properties
    
    private(set) var question: QuestionModel!
    private(set) var answerType: QuizModel.QuestionAnswerType!
    private(set) var questionCountProgressString: String!
    private(set) var answerButtons = [AnswerButton]()
    
    weak var delegate: QuestionViewModelDelegate?
    
    // MARK: - Init
    
    init(questionModel: QuestionModel, answerType: QuizModel.QuestionAnswerType, questionCountProgressString: String) {
        super.init()
        
        self.question = questionModel
        self.answerType = answerType
        self.questionCountProgressString = questionCountProgressString
    }
    
    // MARK: - Public
    
    func setupAnswerButtons() -> [AnswerButton] {
        answerButtons.removeAll()
        for answer in question.answers {
            let button = AnswerButton.button(withAnswer: answer, selectable: answerType == .multipleCorrectAnswers)
            answerButtons.append(button)
        }
        
        return answerButtons
    }
    
    func answerSelected(button: AnswerButton) {
        switch answerType {
        case .singleCorrectAnswer:
            selectAnswerAndEvaluate(button: button)
        case .multipleCorrectAnswers:
            toggleAnswerButton(button: button)
        default: break
        }
    }
    
    func evalueateQuestion() {
        for (index, button) in answerButtons.enumerated() {
            if question.answers[index].isCorrect {
                button.setState(state: .corrent)
            } else if button.isSelected == true && question.answers[index].isCorrect == false {
                button.setState(state: .wrong)
            } else {
                button.setState(state: .neutral, animated: false)
            }
        }
        
        delegate?.updateAnsweringStte(state: .answered)
        delegate?.updateButtomButtonStyle(style: .nextQuestion)
    }
    
    // MARK: - Private
    
    private func toggleAnswer(fromButton button: AnswerButton) {
        if let answer = button.answer {
            answer.isSelected.toggle()
            delegate?.answerButtonSelected(button: button)
        }
    }
    
    private func selectAnswerAndEvaluate(button: AnswerButton) {
        button.isSelected.toggle() // select answer
        toggleAnswer(fromButton: button)
        
        evalueateQuestion()
    }
    
    private func toggleAnswerButton(button: AnswerButton) {
        toggleAnswer(fromButton: button)

        if self.isAnswerSelected() {
            delegate?.updateAnsweringStte(state: .selecting)
            delegate?.updateButtomButtonStyle(style: .confirm)
        } else {
            delegate?.updateButtomButtonStyle(style: .hidden)
            delegate?.updateAnsweringStte(state: .unanswered)
        }
    }
    
    private func isAnswerSelected() -> Bool {
        for answer in question.answers {
            if answer.isSelected {
                return true
            }
        }
        return false
    }
}
