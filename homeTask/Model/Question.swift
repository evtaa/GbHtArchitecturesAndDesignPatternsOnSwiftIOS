//
//  Question.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 15.12.2020.
//

import Foundation

struct Question: Codable {
    var textQuestion: String
    var textAnswers: Dictionary <String,Bool>
}
