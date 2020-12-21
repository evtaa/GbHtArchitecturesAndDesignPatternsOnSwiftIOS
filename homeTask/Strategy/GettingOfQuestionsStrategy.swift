//
//  GettingOfQuestionsStrategy.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 20.12.2020.
//

import Foundation

protocol GettingOfQuestionStrategy {
    func getQuestion () -> Question
}

class SequentialGettingQuestion: GettingOfQuestionStrategy {
    func getQuestion() -> Question {
        
            guard let gameSession = Game.shared.gameSession,
                let question = gameSession.remainingQuestions.first
            else {
                return Question (textQuestion: "Вопросы закончились", textAnswers: ["Ответ 1" : false, "Ответ 2" : false,"Ответ 3" : false,"Ответ 4" : false])
            }
            gameSession.usedQuestions.append(question)
            
            return question
    }
    
}

class RandomGettingQuestion: GettingOfQuestionStrategy {
    func getQuestion() -> Question {
        guard let gameSession = Game.shared.gameSession,
            let question = gameSession.remainingQuestions.randomElement()
        else {
            return Question (textQuestion: "Вопросы закончились", textAnswers: ["Ответ 1" : false, "Ответ 2" : false,"Ответ 3" : false,"Ответ 4" : false])
        }
        gameSession.usedQuestions.append(question)
        
        return question
    }
    
}
