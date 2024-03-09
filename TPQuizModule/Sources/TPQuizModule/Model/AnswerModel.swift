//
//  AnswerModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 22/02/2024.
//

import Foundation

public class AnswerModel: Codable {
    
    // MARK: - Properties
    
    let id: UUID
    let answerString: String
    let isCorrect: Bool
    var isSelected: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, answerString, isCorrect
    }
}
