//
//  GameSession.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import Foundation

class GameSession {
    var flagCompleteGame: Bool = false
    var resultCheckAnswer: Bool?
    let limitQuestions = 5
    var usedQuestions: [Question] = []
    var questions: [Question] = [Question (textQuestion: "Какой газ преобладает в атмосфере Земли?",
                                           textAnswers: ["Кислород" : false,
                                                         "Азот" : true,
                                                         "Углекислый газ" : false,
                                                         "Водород" : false]),
                                 Question (textQuestion: "Кто из этих деятелей искусства стал директором первого профессионального публичного театра России?",
                                           textAnswers: ["Василий Каратыгин" : false,
                                                         "Александр Сумароков" : true,
                                                         "Павел Молчанов" : false,
                                                         "Яков Княжнин" : false]),
                                 Question (textQuestion: "Какой вид спорта не входит в современное пятиборье?    ",
                                           textAnswers: ["Верховая езда" : false,
                                                         "Метание копья" : true,
                                                         "Фехтование" : false,
                                                         "Плавание" : false]),
                                 Question (textQuestion: "Как иначе называют пиратский флаг?",
                                           textAnswers: ["Грязный Гарри" : false,
                                                         "Весёлый Роджер" : true,
                                                         "Бедный Йорик" : false,
                                                         "Лимонадный Джо" : false]),
                                 Question (textQuestion: "Какой фильм Феллини сделал имя Папарацци нарицательным?",
                                           textAnswers: ["Восемь с половиной" : false,
                                                         "Сладкая жизнь" : true,
                                                         "Ночи Кабирии" : false,
                                                         "Дорога" : false]),
                                 Question (textQuestion: "Что является характеристикой коллекционного вина?    ",
                                           textAnswers: ["Стойкость" : false,
                                                         "Выдержка" : true,
                                                         "Выносливость" : false,
                                                         "Трезвость" : false]),
                                 Question (textQuestion: "Как называется популярный рецепт приготовления макарон с мясом?",
                                           textAnswers: ["По-деревенски" : false,
                                                         "По-флотски" : true,
                                                         "По-братски" : false,
                                                         "По-божески" : false])]
    
    var countQuestions: Int {
        get {
            return questions.count
        }
    }
    
    var countUsedQuestions: Int {
        get {
            return usedQuestions.count
        }
    }
    
    var remainingQuestions: [Question] {
        get {
            var remainingQuestions: [Question] = questions
            for question in usedQuestions {
                remainingQuestions = remainingQuestions.filter { $0.textQuestion != question.textQuestion }
            }
            return remainingQuestions
        }
    }
    
    var countTrueAnswers = 0
    
    func getQuestion() -> Question {
        guard let question = remainingQuestions.randomElement() else {
            return Question (textQuestion: "Вопросы закончились", textAnswers: ["1" : false,
                                                                                                  "2" : false,
                                                                                                  "3" : false,
                                                                                                  "4" : false])
        }
        
        return question
    }
}

func checkAnswer (question: Question, answer: String?) -> Bool? {
    guard let answer =  answer else { return nil }
    return question.textAnswers [answer]
}

extension GameSession: gameViewControllerDelegate {
    
    func chooseAnswer(question: Question, answer: String?, flagCompleteGame: Bool) {
        if flagCompleteGame {
            self.flagCompleteGame = true
        } else {
            usedQuestions.append(question)
            resultCheckAnswer = checkAnswer(question: question, answer: answer)
            if let check = resultCheckAnswer,
               check {
                countTrueAnswers += 1
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
