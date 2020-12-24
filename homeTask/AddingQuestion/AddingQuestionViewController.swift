//
//  AddingQuestionViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 20.12.2020.
//

import UIKit

class AddingQuestionViewController: UIViewController {

    var alert = UIAlertController()
    
    @IBOutlet weak var questionUITextField: UITextField!
    @IBOutlet weak var rightAnswerUITextField: UITextField!
    @IBOutlet weak var firstWrongAnswerUITextField: UITextField!
    @IBOutlet weak var secondWrongAnswerUITextField: UITextField!
    @IBOutlet weak var thirdWrongAnswerUITextField: UITextField!
    
    @IBAction func backTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addQuestionTouchUpInside(_ sender: Any) {
        var textQuestion: String = ""
        var textAnswers: Dictionary<String,Bool> = [:]
        if  let text = questionUITextField.text,
            let rightAnswer = rightAnswerUITextField.text,
            let firstWrongAnswer = firstWrongAnswerUITextField.text,
            let secondWrongAnswer = secondWrongAnswerUITextField.text,
            let thirdWrongAnswer = thirdWrongAnswerUITextField.text {
            let arrayAnswers = [rightAnswer, firstWrongAnswer, secondWrongAnswer, thirdWrongAnswer]
            let countAnswers = arrayAnswers.count
            let set = Set(arrayAnswers)
            let countUniqueAnswers = set.count
            if countAnswers != countUniqueAnswers || text == "" || rightAnswer == "" || firstWrongAnswer == "" || secondWrongAnswer == "" || thirdWrongAnswer == "" {
                setupNonCorrectDataAlert ()
                self.present(alert, animated: true, completion: nil)
            } else {
                textQuestion = text
                textAnswers.updateValue(true, forKey: rightAnswer)
                textAnswers.updateValue(false, forKey: firstWrongAnswer)
                textAnswers.updateValue(false, forKey: secondWrongAnswer)
                textAnswers.updateValue(false, forKey: thirdWrongAnswer)
                let question = Question (textQuestion: textQuestion, textAnswers: textAnswers)
                let game = Game.shared
                game.addQuestion(question: question)
                setupAddQuestionAlert ()
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func resetAdditionalQuestionsTouchUpInside(_ sender: Any) {
        let game = Game.shared
        game.resetAdditionalQuestions()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupNonCorrectDataAlert () {
        alert = UIAlertController(title: "Ошибка", message: "Введены некорректные данные", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
    }
    
    private func setupAddQuestionAlert () {
        alert = UIAlertController(title: "Уведомление", message: "Вопрос добавлен", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: { [weak self] action in self?.dismiss(animated: true, completion: nil) }))
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
