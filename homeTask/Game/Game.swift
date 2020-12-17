//
//  Game.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import Foundation

class Game {
    static let shared = Game ()
    
    var gameSession: GameSession? = GameSession ()
    var records: [Record] = [] {
        didSet {
            self.recordsCaretaker.saveRecords(records: records)
        }
    }
    private var recordsCaretaker = RecordsCaretaker ()
    
    
    private init () {
        self.records = self.recordsCaretaker.retrieveRecords()
    }
    
    func addRecord (record: Record) {
        self.records.append(record)
    }
    
    func clearRecords () {
        self.records = []
    }
    
}
