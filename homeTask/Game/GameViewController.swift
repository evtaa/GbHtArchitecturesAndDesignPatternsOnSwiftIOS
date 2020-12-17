//
//  GameViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import UIKit

protocol gameViewControllerDelegate: class {
    func chooseAnswer (question: Question, answer: String?, flagCompleteGame: Bool)
}

class GameViewController: UIViewController {
    
    weak var delegate: gameViewControllerDelegate?
    var question: Question?
    
    @IBOutlet weak var questionUILabel: UILabel!
    @IBOutlet weak var answerAUIButton: UIButton!
    @IBOutlet weak var answerBUIButton: UIButton!
    @IBOutlet weak var answerCUIButton: UIButton!
    @IBOutlet weak var answerDUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameSession = GameSession ()
        delegate = gameSession.self
        Game.shared.gameSession = gameSession
        setupViewController ()
        configQuestionForViewController()
    }
    
    @IBAction func answerATouchUpInside(_ sender: Any) {
        if let question = question,
           let answer = answerAUIButton.currentTitle {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: false)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerBTouchUpInside(_ sender: Any) {
        if let question = question,
           let answer = answerBUIButton.currentTitle {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: false)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerCTouchUpInside(_ sender: Any) {
        if let question = question,
           let answer = answerCUIButton.currentTitle {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: false)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerDTouchUpInside(_ sender: Any) {
        if let question = question,
           let answer = answerDUIButton.currentTitle {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: false)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func finishGameTouchUpInside(_ sender: Any) {
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: nil, flagCompleteGame: true)
        }
        checkEndingGame()
    }
    
    private func checkEndingGame () {
        
        if let countUsedQuestions = Game.shared.gameSession?.countUsedQuestions,
           let limitQuestions = Game.shared.gameSession?.limitQuestions,
           let countTrueAnswers = Game.shared.gameSession?.countTrueAnswers,
           let flagCompleteGame = Game.shared.gameSession?.flagCompleteGame,
           countUsedQuestions == limitQuestions || flagCompleteGame {
            
            let score = Int(ceil(Double(countTrueAnswers) / Double(limitQuestions)*100))
            if score != 0 {
                let record = Record(date: Date (), score: score)
                Game.shared.addRecord(record: record)
            }
            Game.shared.gameSession = nil
            self.dismiss(animated: true, completion: nil)
        } else if let resultCheckAnswer = Game.shared.gameSession?.resultCheckAnswer,
                  !resultCheckAnswer {
            Game.shared.gameSession = nil
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupViewController () {
        questionUILabel.textAlignment = .center
    }
    
    private func configQuestionForViewController () {
        if let question = Game.shared.gameSession?.getQuestion ()
        {
            self.question = question
            questionUILabel.text = question.textQuestion
            var answers = [String] (question.textAnswers.keys)
            var answersUIButton: [UIButton] = []
            answersUIButton.append(answerAUIButton)
            answersUIButton.append(answerBUIButton)
            answersUIButton.append(answerCUIButton)
            answersUIButton.append(answerDUIButton)
            
            for answerUIButton in answersUIButton {
                let answer = answers.randomElement()
                answerUIButton.setTitle(answer, for: .normal)
                answers = answers.filter { $0 != answer }
            }
        }
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
