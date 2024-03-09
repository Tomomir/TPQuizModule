//
//  QuizIntroViewController.swift
//  Quiz
//
//  Created by Tomas Pecuch on 03/03/2024.
//

import UIKit

class QuizIntroViewController: UIViewController {

    // MARK: - Properties
    
    var viewModel: QuizIntroViewModel!
    private var selectedIndex: Int = 0

    // MARK: - Outlets
    
    @IBOutlet weak var previewCollectionView: UICollectionView!
    @IBOutlet weak var closeBarButtonitem: UIBarButtonItem!
    @IBOutlet weak var startQuizButton: LoadingButton!
    
    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        previewCollectionView.register(UINib(nibName: QuizPreviewCollectionViewCell.identifier, bundle: Bundle.module), forCellWithReuseIdentifier: QuizPreviewCollectionViewCell.identifier)
        previewCollectionView.delegate = self
        previewCollectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            let indexPathToScroll = IndexPath(item: 0, section: 0)
            self?.previewCollectionView.scrollToItem(at: indexPathToScroll, at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func closeBarButtonItemPressed(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func startQuizButtonPressed(_ sender: Any) {
        startQuizButton.startLoading()
        
        let selectedPreview = viewModel.previews[selectedIndex]
        viewModel.loadQuiz(quizId: selectedPreview.quizId) { [weak self] quizController in
            self?.startQuizButton.stopLoading()
            if let controller = quizController {
                self?.navigationController?.pushViewController(controller, animated: true)
            } else {
                //here we would have to display error message from failed API request
            }
        }
    }

}

extension QuizIntroViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPreviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = viewModel.previewCell(forCollectionView: collectionView, forIndexPath: indexPath) {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width * 0.5, height: collectionView.bounds.size.height * 0.5)
    }
    
    // to update current selected quiz preview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(x: scrollView.contentOffset.x + (scrollView.bounds.width / 2), y: (scrollView.bounds.height / 2))
        
        if let indexPath = self.previewCollectionView.indexPathForItem(at: centerPoint) {
            selectedIndex = indexPath.item
        }
    }
}
