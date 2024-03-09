//
//  ViewController.swift
//  QuizAppExample
//
//  Created by Tomas Pecuch on 08/03/2024.
//

import UIKit
import TPQuizModule

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("vc did load")
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        let module = TPQuizModule(dataSource: QuizDataSource())
        if let navVC = navigationController {
            module.presentQuiz(fromNavigationController: navVC)
        }
    }
}

