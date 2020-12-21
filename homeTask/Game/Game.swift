//
//  Game.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import Foundation

class Game {
    
    static let shared = Game ()
    var gameSession: GameSession?
    
    private var recordsCaretaker = RecordsCaretaker ()
    private var additionalQuestionsCaretaker = AdditionalQuestionsCaretaker ()
    private var settingCaretaker = SettingCaretaker ()
    
    var records: [Record] = [] {
        didSet {
            self.recordsCaretaker.saveRecords(records: records)
        }
    }
    var additionalQuestions: [Question] = [] {
        didSet {
            self.additionalQuestionsCaretaker.saveAdditionalQuestions(additionalQuestions: additionalQuestions)
        }
    }
    var orderOfQuestions: OrderOfQuestions = .sequential {
        didSet {
            self.settingCaretaker.saveOrderOfQuestions(orderOfQuestions: orderOfQuestions)
        }
    }
    
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
    
    private init () {
        self.records = self.recordsCaretaker.retrieveRecords()
        self.additionalQuestions = self.additionalQuestionsCaretaker.retrieveAdditionalQuestions()
        self.orderOfQuestions = self.settingCaretaker.retrieveOrderOfQuestions()
    }
    
    func addRecord (record: Record) {
        self.records.append(record)
    }
    func clearRecords () {
        self.records = []
    }
    
    func addQuestion (question: Question) {
        self.additionalQuestions.append(question)
    }
    func resetAdditionalQuestions () {
        self.additionalQuestions = []
    }
}
