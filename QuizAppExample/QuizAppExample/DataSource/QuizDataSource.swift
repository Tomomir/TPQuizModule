//
//  QuizDataSource.swift
//  Quiz
//
//  Created by Tomas Pecuch on 01/03/2024.
//

import Foundation
import TPQuizModule

class QuizDataSource: NSObject, QuizModuleDataSourceDelegate {
    
    // handle quiz result as desired
    func quizFinished(withData quiz: QuizModel) {
//        for question in quiz.questions {
//            print("\(question.questionString) \(question.isAnsweredCorrectrly())")
//        }
    }

    // we mock async call here to show support for the future API calls
    // we are loading all the quizzes at the same time which is not optimal, using API call we would not need to do that
    func fetchQuizData(forQuizId quizId: UUID, completion: @escaping ((QuizModel?) -> Void)) {
        if let quizArray = FileManager.loadQuizArrayFromFile(fileName: "QuizExampleFile") {
            //to simulate asynchronous operation
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                let quiz = quizArray.quizArray.first { quiz in
                    quiz.id == quizId
                }
                completion(quiz)
            }
            
        } else {
            // handle possible errors here - need to add error param to completion
            // for example instead "(QuizModel) -> Void" we could use "(Result<QuizModel, Error>) -> Void"
        }
    }
    
    // since we dont want to load all quizzes beforehand (because it could be waste of data usage), we start with previews and load the quiz just before showing it
    func getQuizPreviews() -> [QuizPreviewModel] {
        if let quizPreviews = FileManager.loadQuizPreviewsFromFile(fileName: "QuizPreviewsExampleFile") {
            return quizPreviews.previewArray
        } else {
            return [QuizPreviewModel]()
        }
    }
}
