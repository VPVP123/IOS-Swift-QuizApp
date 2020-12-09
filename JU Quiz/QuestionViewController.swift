//
//  QuestionViewController.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-11-05.
//

import UIKit
import CoreData

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    
    private var haveWon = false
    var questions: [Question] = []{
        didSet{
            question = questions.removeFirst()
        }
    }
    var question: Question?
    var numberOfQuestions = 0
    var rightAnswers = 0
    var difficulty = "easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        //configure of the question label
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20
        
        var buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
        //Config of buttons
        buttons.forEach{ (button) in
            button?.layer.cornerRadius = 20
        }
        
        questionLabel.text = question?.question
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer, for: .normal)
        
        question?.incorrectAnswers.forEach({(answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer, for: .normal)
        })
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("View did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("View will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("View did disappear")
    }
    
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        if buttonAnswerA.title(for: .normal) == question?.correctAnswer{
            showRightAnswerAlert(button: buttonAnswerA)
        }else{
            showWrongAnswerAlert(button: buttonAnswerA)
        }
    }
    
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        if buttonAnswerB.title(for: .normal) == question?.correctAnswer{
            showRightAnswerAlert(button: buttonAnswerB)
        }else{
            showWrongAnswerAlert(button: buttonAnswerB)
        }
    }
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        if buttonAnswerC.title(for: .normal) == question?.correctAnswer{
            showRightAnswerAlert(button: buttonAnswerC)
        }else{
            showWrongAnswerAlert(button: buttonAnswerC)
        }
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        if buttonAnswerD.title(for: .normal) == question?.correctAnswer{
            showRightAnswerAlert(button: buttonAnswerD)
        }else{
            showWrongAnswerAlert(button: buttonAnswerD)
        }
    }
    
    private func showRightAnswerAlert(button: UIButton){
        haveWon = true
        rightAnswers += 1
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "RIGHT ANSWER", message: "Go on...", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes!", style: UIAlertAction.Style.default, handler: { [weak self]
            (UIAlertAction) in
            self?.goToNextScreen()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showWrongAnswerAlert(button: UIButton){
        haveWon = false
        button.backgroundColor = .red
        let alertController = UIAlertController(title: "WRONG ANSWER", message: "Maybe next time...", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Oh no...", style: UIAlertAction.Style.default, handler: { [weak self]
            (UIAlertAction) in
            self?.goToNextScreen()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func goToNextScreen(){
        guard !questions.isEmpty, let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else {
            saveGameResult()
            performSegue(withIdentifier: "ResultView", sender: nil)
            return
        }
        questionViewController.numberOfQuestions = numberOfQuestions
        questionViewController.rightAnswers = rightAnswers
        questionViewController.questions = questions
        questionViewController.difficulty = difficulty
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    private func saveGameResult(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        if let gameResult = NSEntityDescription.insertNewObject(forEntityName: "GameResult", into: managedObjectContext) as? GameResult {
            gameResult.numberOfQuestions = Int32(numberOfQuestions)
            gameResult.rightAnswers = Int32(rightAnswers)
            gameResult.date = Date()
            gameResult.difficulty = difficulty
            appDelegate.saveContext()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController{
            resultViewController.resultView.resultLabel.text = "You answered \(rightAnswers)/\(numberOfQuestions) questions right."
        }
    }

}
