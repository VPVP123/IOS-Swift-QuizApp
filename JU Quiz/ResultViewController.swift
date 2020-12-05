//
//  ResultViewController.swift
//  JU Quiz
//
//  Created by Victor Svanqvist on 2020-12-05.
//

import UIKit

class ResultViewController: UIViewController {

    let resultView = ResultView()
    
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultView.button.addTarget(self, action: #selector(backButtonHandler), for: .touchUpInside)
    }
    
    @objc private func backButtonHandler() {
        navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
