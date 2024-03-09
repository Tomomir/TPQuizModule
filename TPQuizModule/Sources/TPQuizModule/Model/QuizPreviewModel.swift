//
//  QuizPreviewModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 05/03/2024.
//

import Foundation

public class QuizPreviewArrayModel: Codable {
    
    // MARK: - Properties
    
    public let previewArray: [QuizPreviewModel]
}

public class QuizPreviewModel: Codable {
    
    // MARK: - Properties
    
    let quizId: UUID
    let title: String
    let iconName: String // in real project, this would probably be icon URL
}
