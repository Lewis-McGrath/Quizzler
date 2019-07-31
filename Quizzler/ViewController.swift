//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickAnswer: Bool = false
    var questionNumber: Int = 0
    var scoreNumber: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickAnswer = true
        }
        else {
            pickAnswer = false
        }
        
         checkAnswer()
        
         questionNumber += 1
         nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(scoreNumber)"
        progressLabel.text = "\(questionNumber + 1)/13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
             questionLabel.text = allQuestions.list[questionNumber].questionText
            
            updateUI()
        } else {
          let alert = UIAlertController(title: "Well Done!", message: "You have now finsihed the quiz. Would you like to restart?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true , completion: nil)
        }
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickAnswer {
            ProgressHUD.showSuccess("Correct!")
           scoreNumber += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    func startOver() {
       questionNumber = 0
       scoreNumber = 0
        nextQuestion()
    }
    

    
}
