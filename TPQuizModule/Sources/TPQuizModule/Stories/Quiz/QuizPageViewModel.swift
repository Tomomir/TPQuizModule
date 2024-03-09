//
//  QuizViewModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 22/02/2024.
//

import Foundation
import UIKit

class QuizPageViewModel: NSObject {

    // MARK: - Properties
    
    private(set) var quiz: QuizModel!
    
    var quizFinishedCallback: ((_ quiz: QuizModel) -> Void)?
    
    /* if we want to be able to scroll freely through questions, our dataSource could look like this
         lazy var questionControllersArray: [QuestionViewController] = {
             quiz.questions.enumerated().map { (index,questionModel) in
                 let viewController = TPQuizModule.makeQuestionViewController(questionViewModel: QuestionViewModel(questionModel: questionModel, isSingleCorrectAnswer: quiz.isSingleCorrectAnswer()))
                 viewController.title = quiz.title
                 return viewController
             }
         }()
     */
    
    // MARK: - Init
    
    init(quiz: QuizModel) {
        super.init()
        self.quiz = quiz
    }
    
    // MARK: - Public

    // we would implement this if we want to freely scroll through the quiz questions
    func viewController(before viewController: QuestionViewController) -> QuestionViewController? {
        return nil
    }
    
    func viewController(after viewController: QuestionViewController) -> UIViewController? {
        let currentQuestion = viewController.viewModel.question
        
        if let currentQuestionIndex = quiz.questions.firstIndex(where: { model in
            model.id == currentQuestion?.id
        }) {
            if currentQuestionIndex + 1 < quiz.questions.count {
                let nextQuestionModel = quiz.questions[currentQuestionIndex + 1]
                let nextQuestionController = TPQuizModule.makeQuestionViewController(questionViewModel: QuestionViewModel(questionModel: nextQuestionModel, answerType: quiz.questionAnswerType(), questionCountProgressString: "\(currentQuestionIndex + 2)/\(quiz.questions.count)"))
                nextQuestionController.title = quiz.title
                return nextQuestionController
            }
            if currentQuestionIndex + 1 == quiz.questions.count { // we run out of questions, show summary
                quizFinishedCallback?(quiz) // since we are showing summary screen, quiz is completed, we can call the callback to send result state of our model outside of TPQuizModule
                
                let outroViewController = TPQuizModule.makeOutroViewController(viewModel: QuizOutroViewModel(quizModel: quiz))
                outroViewController.title = quiz.title
                return outroViewController
            }
        }
        
        return nil
    }
    
    func inititalViewController() -> QuestionViewController? {
        guard let firstQuestionModel = quiz.questions.first else { return nil }
        let viewController = TPQuizModule.makeQuestionViewController(questionViewModel: QuestionViewModel(questionModel: firstQuestionModel, answerType: quiz.questionAnswerType(), questionCountProgressString: "1/\(quiz.questions.count)"))
        viewController.title = quiz.title
        return viewController
    }
}
