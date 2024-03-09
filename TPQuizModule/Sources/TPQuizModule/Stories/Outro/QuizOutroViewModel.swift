//
//  QuizOutroViewModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 07/03/2024.
//

import Foundation


class QuizOutroViewModel: NSObject {
    
    // MARK: - Properties
    
    private(set) var quiz: QuizModel!
    
    // MARK: - Init
    
    init(quizModel: QuizModel) {
        self.quiz = quizModel
    }
    
    // MARK: - Public
    
    // normally we would localize our strings and handle plurals there (for example if we wanted to use question vs questions)
    func getQuizResultsString() -> String {
        let totalQuestions = quiz.numberOfQuestions()
        let correctlyAnsweredQuestions = quiz.numberOfCorrecttlyAnsweredQuestions()
        var resultString = ""
        
        switch (totalQuestions, correctlyAnsweredQuestions) {
        case (_, let correctlyAnswered) where correctlyAnswered == totalQuestions: // All questions answered correctly
            resultString.append("Perfect!\n")
        case (_, let correctlyAnswered) where correctlyAnswered >= totalQuestions / 2: // Less than all but at least half answered correctly
            resultString.append("Awsome!\n")
        case (_, let correctlyAnswered) where correctlyAnswered > 0: // Less than half but at least 1 answered correctly
            resultString.append("Not Bad!\n")
        default: // No question answered correctly
            resultString.append("What a Fail!\n")
        }
        
        var successPercentage = Int(round((Double(correctlyAnsweredQuestions) / Double(totalQuestions)) * 100))
        resultString.append("Success rate: \(successPercentage)%")
        
        return resultString
    }
    
}
