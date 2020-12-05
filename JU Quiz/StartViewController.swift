//
//  StartViewController.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-05.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController{
            let question = Question(category: "Food", type: .multiple, difficulty: .easy, question: "How are you today?", correctAnswer: "Bad", incorrectAnswers: ["Good", "Medium", "Not bad"])
            questionViewController.question = question
        }
    }

}
