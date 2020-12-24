//
//  GameSession.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import Foundation

class GameSession {
    internal init(gettingOfQuestionStrategy: GettingOfQuestionStrategy, limitQuestions: Int) {
        self.gettingOfQuestionStrategy = gettingOfQuestionStrategy
        self.limitQuestions = limitQuestions
    }
    
    private var gettingOfQuestionStrategy: GettingOfQuestionStrategy
    var flagCompleteGame: Bool = false
    var resultCheckAnswer: Bool?
    var limitQuestions: Int = 5
    var usedQuestions: [Question] = []
    var additionalQuestions: [Question] = Game.shared.additionalQuestions
    var questions: [Question] = Game.shared.questions
    var countUsedQuestions = Observable<Int>(0)
    var percentTrueAnswers = Observable<Int>(0)
    var countTrueAnswers: Int = 0
    
    var countQuestions: Int {
        get {
            return questions.count
        }
    }
    
    var remainingQuestions: [Question]
    {
        get {
            var remainingQuestions: [Question] = questions + additionalQuestions
            for question in usedQuestions {
                remainingQuestions = remainingQuestions.filter { $0.textQuestion != question.textQuestion }
            }
            return remainingQuestions
        }
    }
    
    func getQuestion() -> Question {
        gettingOfQuestionStrategy.getQuestion()
    }
    
    func checkAnswer (question: Question, answer: String?) -> Bool? {
        guard let answer = answer else { return nil }
        return question.textAnswers [answer]
    }
}
extension GameSession: GameViewControllerDelegate {
    
    func chooseAnswer(question: Question, answer: String?, flagCompleteGame: Bool) {
        if flagCompleteGame {
            self.flagCompleteGame = true
        } else {
            resultCheckAnswer = checkAnswer(question: question, answer: answer)
            if let check = resultCheckAnswer,
               check {
                countTrueAnswers += 1
                percentTrueAnswers.value = Int(ceil(Double(countTrueAnswers) / Double(limitQuestions)*100))
                countUsedQuestions.value = usedQuestions.count
            }
        }
        

        debugPrint(usedQuestions)
        debugPrint(usedQuestions.count)
        debugPrint(remainingQuestions)
        debugPrint(remainingQuestions.count)
        debugPrint(question)
        debugPrint(answer)
    }
}
