//
//  GameViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import UIKit

protocol GameViewControllerDelegate: class {
    func chooseAnswer (question: Question, answer: String?, flagCompleteGame: Bool)
}

class GameViewController: UIViewController {
    
    var alert = UIAlertController()
    weak var delegate: GameViewControllerDelegate?
    var gettingOfQuestionStrategy: GettingOfQuestionStrategy {
        get {
            switch Game.shared.orderOfQuestions {
            case .sequential:
                return SequentialGettingQuestion ()
            case .random:
                return RandomGettingQuestion ()
            }
        }
    }
    var question: Question?
    var flagCompleteGame: Bool = false
    var answer: String? = nil
    
    @IBOutlet weak var questionUILabel: UILabel!
    @IBOutlet weak var answerAUIButton: UIButton!
    @IBOutlet weak var answerBUIButton: UIButton!
    @IBOutlet weak var answerCUIButton: UIButton!
    @IBOutlet weak var answerDUIButton: UIButton!

    @IBOutlet weak var numberOfCurrentQuestionUILabel: UILabel!
    @IBOutlet weak var percentTrueAnswersUILabel: UILabel!
    
    @IBAction func answerATouchUpInside(_ sender: Any) {
        answer = answerAUIButton.currentTitle
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: flagCompleteGame)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerBTouchUpInside(_ sender: Any) {
        answer = answerBUIButton.currentTitle
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: flagCompleteGame)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerCTouchUpInside(_ sender: Any) {
        answer = answerCUIButton.currentTitle
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: flagCompleteGame)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func answerDTouchUpInside(_ sender: Any) {
        answer = answerDUIButton.currentTitle
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: flagCompleteGame)
        }
        checkEndingGame()
        configQuestionForViewController()
    }
    
    @IBAction func finishGameTouchUpInside(_ sender: Any) {
        answer = nil
        flagCompleteGame = true
        if let question = question {
            delegate?.chooseAnswer(question: question, answer: answer, flagCompleteGame: flagCompleteGame)
        }
        checkEndingGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameSession = GameSession (gettingOfQuestionStrategy: gettingOfQuestionStrategy, limitQuestions: 6)
        delegate = gameSession.self
        Game.shared.gameSession = gameSession
        setupViewController ()
        configQuestionForViewController()
        configCurrentResult ()
    }
    
    private func configCurrentResult () {
        let gameSession = Game.shared.gameSession
        gameSession?.countUsedQuestions.addObserver(self, options: [.new, .initial], closure: { [weak self] (countUsedQuestions, _) in
            self?.numberOfCurrentQuestionUILabel.text = "Вопрос № \(countUsedQuestions + 1)"
        })
        
        gameSession?.percentTrueAnswers.addObserver(self,options: [.new, .initial], closure: { [weak self] (percentTrueAnswers,_) in
            self?.percentTrueAnswersUILabel.text = "Вы ответили на \(percentTrueAnswers) процентов вопросов"
        })
    }
    
    private func setupViewController () {
        questionUILabel.textAlignment = .center
        numberOfCurrentQuestionUILabel.textAlignment = .center
        percentTrueAnswersUILabel.textAlignment = .center
    }
    
    private func setupGameOverAlert () {
        alert = UIAlertController(title: "Уведомление", message: "Вы проиграли", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { [weak self] action in
                                        Game.shared.gameSession = nil
                                        self?.dismiss(animated: true, completion: nil) }))
    }
    
    private func setupWinerAlert () {
        let percentTrueAnswers = Game.shared.gameSession?.percentTrueAnswers
        alert = UIAlertController(title: "Уведомление", message: "Вы ответили на \(percentTrueAnswers?.value ?? 0) процентов вопросов", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { [weak self] action in
                                        Game.shared.gameSession = nil
                                        self?.dismiss(animated: true, completion: nil) }))
    }
    
    private func setupAbsoluteWinerAlert () {
        alert = UIAlertController(title: "Уведомление", message: "Вы ответили на все вопросы", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { [weak self] action in
                                        Game.shared.gameSession = nil
                                        self?.dismiss(animated: true, completion: nil) }))
    }
    
    private func checkEndingGame () {
        
        if let gameSession = Game.shared.gameSession {
            let countUsedQuestions = gameSession.countUsedQuestions
            let limitQuestions = gameSession.limitQuestions
            let flagCompleteGame = gameSession.flagCompleteGame
            let percentTrueAnswers = gameSession.percentTrueAnswers
            if let resultCheckAnswer = gameSession.resultCheckAnswer,
               !resultCheckAnswer {
                setupGameOverAlert()
                present(alert, animated: true, completion: nil)
            } else {
                if countUsedQuestions.value == limitQuestions {
                    let score = percentTrueAnswers.value
                    if score != 0 {
                        let record = Record(date: Date (), score: score)
                        Game.shared.addRecord(record: record)
                    }
                    setupAbsoluteWinerAlert ()
                    present(alert, animated: true, completion: nil)
                } else if flagCompleteGame {
                    let score = percentTrueAnswers.value
                    if score != 0 {
                        let record = Record(date: Date (), score: score)
                        Game.shared.addRecord(record: record)
                    }
                    setupWinerAlert ()
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    private func configQuestionForViewController () {
        if let question = Game.shared.gameSession?.getQuestion ()
        {
            self.question = question
            questionUILabel.text = question.textQuestion
            var answers = [String] (question.textAnswers.keys)
            answers.shuffle()
            var answersUIButton: [UIButton] = []
            answersUIButton.append(answerAUIButton)
            answersUIButton.append(answerBUIButton)
            answersUIButton.append(answerCUIButton)
            answersUIButton.append(answerDUIButton)
            for (index,answer) in answers.enumerated() {
                let answerUIButton = answersUIButton [index]
                answerUIButton.setTitle(answer, for: .normal)
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
