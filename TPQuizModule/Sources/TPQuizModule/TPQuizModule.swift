//
//  QuizModule.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import Foundation
import UIKit

// implementing this dataSource is all we need to be able to use the quiz module
// the completion block is not necessary for file loading; it's included only to demonstrate how API integration would look
public protocol QuizModuleDataSourceDelegate {
    func fetchQuizData(forQuizId quizId: UUID, completion: @escaping ((QuizModel?) -> Void))
    func getQuizPreviews() -> [QuizPreviewModel]
    func quizFinished(withData quiz: QuizModel)
}

public class TPQuizModule: NSObject {
    
    // MARK: - Properties
    
    private var dataSource: QuizModuleDataSourceDelegate
    
    // MARK: - Init
    
    public init(dataSource: QuizModuleDataSourceDelegate) {
        self.dataSource = dataSource
    }
    
    // MARK: - Public
    
    public func presentQuiz(fromNavigationController parentNavigationController: UINavigationController) {
        let quizNavigationController = UIStoryboard(name: "Quiz", bundle: Bundle.module).instantiateViewController(withIdentifier: "QuizNavigationController") as! UINavigationController
        let introViewController = quizNavigationController.topViewController as? QuizIntroViewController
        
        introViewController?.viewModel = QuizIntroViewModel(quizDataSource: dataSource)
        introViewController?.title = "Quizzes"
        
        parentNavigationController.present(quizNavigationController, animated: true)
    }
    
    //MARK: - Static Helpers
    
    static func makeQuestionViewController(questionViewModel: QuestionViewModel) -> QuestionViewController {
        let newVC = UIStoryboard(name: "Quiz", bundle: Bundle.module).instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        newVC.viewModel = questionViewModel
        return newVC
    }
    
    static func makeQuizPageViewController(viewMoodel: QuizPageViewModel) -> QuizPageViewController {
        let newVC = UIStoryboard(name: "Quiz", bundle: Bundle.module).instantiateViewController(withIdentifier: "QuizPageViewController") as! QuizPageViewController
        newVC.viewModel = viewMoodel
        return newVC
    }
    
    static func makeOutroViewController(viewModel: QuizOutroViewModel) -> QuizOutroViewController {
        let newVC = UIStoryboard(name: "Quiz", bundle: Bundle.module).instantiateViewController(withIdentifier: "OutroViewController") as! QuizOutroViewController
        newVC.viewModel = viewModel
        return newVC
    }
}
