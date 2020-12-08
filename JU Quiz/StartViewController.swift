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
    
    
    @IBOutlet weak var roundScroller: UIPickerView!
    var pickerData: [Int] = [Int]()
    
    var numberOfQuestionss = 1
    
    @IBOutlet weak var difficultyScroller: UIPickerView!
    var difficultyPickerData: [String] = [String]()
    
    var difficulty = "easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.isEnabled = false
        // Do any additional setup after loading the view.
        self.roundScroller.delegate = self
        self.roundScroller.dataSource = self
        
        self.difficultyScroller.delegate = self
        self.difficultyScroller.dataSource = self
        
        difficultyPickerData = ["easy", "medium", "hard"]
        pickerData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }

    @IBAction func highScoreButton(_ sender: Any) {
        let highscoreTableViewController = highScoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }
    
    
    private func downloadQuestions(ammount: Int, dif: String){
        guard let url = URL(string:"https://opentdb.com/api.php?amount=\(ammount)&difficulty=\(dif)&type=multiple") else{
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
            questionViewController.numberOfQuestions = numberOfQuestionss
            questionViewController.questions = questions
        }
    }

}

extension StartViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == roundScroller){
            return pickerData.count
        }
        if(pickerView == difficultyScroller){
            return difficultyPickerData.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        print(pickerData[row])
        if(pickerView == roundScroller){
            return String(pickerData[row])
        }
        if(pickerView == difficultyScroller){
            return difficultyPickerData[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerData[row])
        if(pickerView == roundScroller){
            numberOfQuestionss = pickerData[row]
        }
        if(pickerView == difficultyScroller){
            difficulty = difficultyPickerData[row]
        }
        downloadQuestions(ammount: numberOfQuestionss, dif: difficulty)
    }
    
}
