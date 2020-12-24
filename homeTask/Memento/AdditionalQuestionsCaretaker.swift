//
//  AdditionalQuestionsCaretaker.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 20.12.2020.
//

import Foundation

class AdditionalQuestionsCaretaker {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let key = "additionalQuestions"
    
    func saveAdditionalQuestions (additionalQuestions: [Question]) {
        do {
            let data = try encoder.encode(additionalQuestions)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
        print (error)
        }
    }
    
    func retrieveAdditionalQuestions () -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do{
            let additionalQuestions = try decoder.decode([Question].self, from: data)
            return additionalQuestions
        }
        catch {
            print (error)
            return []
        }
    }
}

