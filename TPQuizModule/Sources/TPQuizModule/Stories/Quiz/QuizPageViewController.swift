//
//  QuizPageViewController.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import UIKit

class QuizPageViewController: UIPageViewController {
    
    // MARK: - Properties
    
    var viewModel: QuizPageViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        setupPages()
    }
    
    // MARK: - Setup
    
    func setupPages() {
        if let initialViewController = viewModel.inititalViewController() {
            initialViewController.delegate = self
            setViewControllers([initialViewController], direction: .forward, animated: true)
        }
    }

}

// not doing anything, by implementing it we could let user swipe among questions without limitations
extension QuizPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}

extension QuizPageViewController: QuestionViewControllerNavigationDelegate {
    func displayNextPage(fromQuestionViewController questionViewController: QuestionViewController) {
        
        if let nextViewController = viewModel.viewController(after: questionViewController) {
            if let nextQuestionViewController = nextViewController as? QuestionViewController {
                nextQuestionViewController.delegate = self
            }
            view.isUserInteractionEnabled = false // to disable unexpected behaviour caused for example by doubleclicking
            setViewControllers([nextViewController], direction: .forward, animated: true) { _ in
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
