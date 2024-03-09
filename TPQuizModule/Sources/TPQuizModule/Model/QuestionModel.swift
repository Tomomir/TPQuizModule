//
//  QuestionModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 22/02/2024.
//

import Foundation

public class QuestionModel: Codable {
    
    // MARK: - Properties
    
    let id: UUID
    public let questionString: String
    public let answers: [AnswerModel]
    
    private enum CodingKeys: String, CodingKey {
        case id, questionString, answers
    }
    
    // MARK: - Public
    
    func isSingleCorrectAnswer() -> Bool {
        var correctAnswers = 0
        
        for answer in answers {
            if answer.isCorrect {
                correctAnswers += 1
            }
        }
        return correctAnswers == 1
    }
    
    public func isAnsweredCorrectrly() -> Bool {
        for answer in answers {
            if answer.isCorrect == true && answer.isSelected == false {
                return false // here we found correct answer that is not selected meaning question was answered not correclty
            }
            if answer.isCorrect == false && answer.isSelected == true {
                return false // here we found selected answer that is incorrect
            }
        }
        
        return true
    }
}
