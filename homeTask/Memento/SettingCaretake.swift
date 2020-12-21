//
//  SettingCaretake.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 20.12.2020.
//

import Foundation

class SettingCaretaker {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let key = "setting"
    
    func saveOrderOfQuestions (orderOfQuestions: OrderOfQuestions) {
        do {
            let data = try encoder.encode(orderOfQuestions)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
        print (error)
        }
    }
    
    func retrieveOrderOfQuestions () -> OrderOfQuestions {
        guard let data = UserDefaults.standard.data(forKey: key) else { return .sequential }
        do{
            let orderOfQuestions = try decoder.decode(OrderOfQuestions.self, from: data)
            return orderOfQuestions
        }
        catch {
            print (error)
            return .sequential
        }
    }
}
