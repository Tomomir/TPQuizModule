//
//  QuizModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 22/02/2024.
//

import Foundation

// I use a Codable subclass to automatically parse model objects from JSON data. Since it works the other way around as well, we would use this approach for data deserialization.
public class QuizModel: Codable {
    
    // MARK: - Enums
    
    enum QuestionAnswerType {
        case singleCorrectAnswer
        case multipleCorrectAnswers
    }
    
    // MARK: - Properties
    
    public let id: UUID
    public let title: String
    public let iconName: String
    public let questions: [QuestionModel]
    
    // MARK: - Public
    
    func numberOfQuestions() -> Int {
        questions.count
    }
    
    // used for showing results
    func numberOfCorrecttlyAnsweredQuestions() -> Int {
        var count: Int = 0
        for question in questions {
            if question.isAnsweredCorrectrly() {
                count += 1
            }
        }
        return count
    }
    
    // My approach is to calculate automatically whether the quiz has a single correct answer.
    // With this approach, we don't need to specify any additional flags. The downside is that we will not be able to create a quiz presented as multiple correct answers where there will be in fact only one correct answer
    func questionAnswerType() -> QuestionAnswerType {
        for question in questions {
            if question.isSingleCorrectAnswer() == false {
                return .multipleCorrectAnswers
            }
        }
        return .singleCorrectAnswer
    }
}
