//
//  AnswerButton.swift
//  Quiz
//
//  Created by Tomas Pecuch on 07/03/2024.
//

import UIKit

class AnswerButton: UIButton {

    // MARK: - Enums

    enum AnswerState {
        case neutral
        case corrent
        case wrong
    }

    // MARK: - Properties
    
    var answer: AnswerModel?
    var selectable: Bool = false
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if selectable {
                switch newValue {
                    case true:
                        self.layer.borderWidth = 4
                    case false:
                        self.layer.borderWidth = 0
                }
            }
            super.isSelected = newValue
        }
    }
    
    // MARK: - Init
    
    static func button(withAnswer answer: AnswerModel, selectable: Bool) -> AnswerButton {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .leading
        config.titleAlignment = .leading
        config.baseBackgroundColor = .systemFill
        config.imagePadding = 10
        config.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 15, bottom: 20, trailing: 15)
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            return outgoing
        }
        
        let button = AnswerButton(configuration: config)
        button.answer = answer
        button.selectable = selectable
        button.contentHorizontalAlignment = .left

        button.setTitle(answer.answerString, for: .normal)
        button.setTitle(answer.answerString, for: .highlighted)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label, for: .selected)
        button.setTitleColor(.label, for: .highlighted)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.cornerRadius = 6
        
        return button
    }

    // MARK: - Public
    
    func toggleSelected() {
        isSelected.toggle()
        
    }
    
    func setState(state: AnswerState, animated: Bool = true) {
        switch animated {
        case true:
            setStateWithAnimation(state: state)
        case false:
            setStateWithoutAnimation(state: state)
        }
    }
    
    // MARK: - Private
    
    private func setStateWithAnimation(state: AnswerState) {
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .transitionFlipFromBottom,
                          animations: { [weak self] in
            self?.configuration?.baseBackgroundColor = self?.colorForState(state: state)
        })
    }
    
    private func setStateWithoutAnimation(state: AnswerState) {
        configuration?.baseBackgroundColor = colorForState(state: state)
    }
    
    private func colorForState(state: AnswerState) -> UIColor {
        switch state {
        case .neutral:
            return UIColor.systemFill
        case .corrent:
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 0.0, green: 204.0/255.0, blue: 0.0, alpha: 1.0) // green color
            } else {
                return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0) // green color
            }
            
        case .wrong:
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor(red: 1.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0) // red color
            } else {
                return UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) // red color
            }
        }
    }
}
