//
//  QuizIntroViewModel.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import Foundation
import UIKit

class QuizIntroViewModel: NSObject {
    
    // MARK: - Properties
    
    private var quizDataSource: QuizModuleDataSourceDelegate!
    private(set) var previews = [QuizPreviewModel]()

    // MARK: - Init
    
    init(quizDataSource: QuizModuleDataSourceDelegate) {
        super.init()
        
        self.quizDataSource = quizDataSource
        self.previews = quizDataSource.getQuizPreviews()
    }
    
    // MARK: - Public
    
    //to handle possible errors like failed API request add Error parametr to the completion closure
    //since this demo uses json file, I'm not gonna implement that now
    //note that depending on the data size, type and desired UX, we could consider to start data load before users taps start
    func loadQuiz(quizId: UUID, completion: @escaping((QuizPageViewController?) -> Void)) {
        quizDataSource.fetchQuizData(forQuizId: quizId) { quizModel in
            if let model = quizModel {
                let quizViewModel = QuizPageViewModel(quiz: model)
                quizViewModel.quizFinishedCallback = { [weak self] quizModel in
                    self?.quizDataSource.quizFinished(withData: quizModel)
                }
                
                let quizViewController = TPQuizModule.makeQuizPageViewController(viewMoodel: quizViewModel)
                quizViewController.title = model.title
                completion(quizViewController)
            } else {
                // here we would return some Error object in completion handler
            }
        }
    }
        
    func numberOfPreviews() -> Int {
        return previews.count
    }
    
    func previewCell(forCollectionView collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> QuizPreviewCollectionViewCell? {
        if indexPath.row >= previews.count { return nil }
        
        let previewModel = previews[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizPreviewCollectionViewCell.identifier, for: indexPath) as! QuizPreviewCollectionViewCell
        cell.setup(withPreview: previewModel)
        
        return cell
    }
}
