//
//  StartViewController.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-05.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    var questions: [Question] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isEnabled = false
        // Do any additional setup after loading the view.
        downloadQuestions(ammount: 5)
    }

    @IBAction func highScoreButton(_ sender: Any) {
        let highscoreTableViewController = highScoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }
    
    
    private func downloadQuestions(ammount: Int){
        guard let url = URL(string:"https://opentdb.com/api.php?amount=\(ammount)&type=multiple") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, monkey, error) in
            guard let data = data else{
                print(error)
                return
            }
            //print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questionsResult = try? decoder.decode(QuestionResult.self, from: data)
            self?.questions = questionsResult?.results ?? []
            DispatchQueue.main.async {
                self?.startButton.isEnabled = true
            }
        }
        task.resume()
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController{
            //let question1 = Question(category: "Food", type: .multiple, difficulty: .easy, question: "How are you today?", correctAnswer: "Bad", incorrectAnswers: ["Good", "Medium", "Not bad"])
            //let question2 = Question(category: "Food", type: .multiple, difficulty: .easy, question: "How are you today?", correctAnswer: "Bad", incorrectAnswers: ["Good", "Medium", "Not bad"])
            //let questions = [question1, question2]
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
        }
    }

}
