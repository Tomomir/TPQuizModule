//
//  QuizPreviewCollectionViewCell.swift
//  Quiz
//
//  Created by Tomas Pecuch on 05/03/2024.
//

import UIKit

class QuizPreviewCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: - Properties
    
    static let identifier = "QuizPreviewCollectionViewCell"
    private(set) var preview: QuizPreviewModel?
    
    // MARK: - Outlets
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var previewLabel: UILabel!
    
    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup
    
    func setup(withPreview quizPreview: QuizPreviewModel) {
        self.preview = quizPreview
        self.previewLabel.text = quizPreview.title
        self.previewImageView.image = UIImage(systemName: quizPreview.iconName) 
    }
}
