//
//  RecordsCaretaker.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 17.12.2020.
//

import Foundation
class RecordsCaretaker {
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    let key = "records"
    
    func saveRecords (records: [Record]) {
        do {
            let data = try encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        }
        catch {
        print (error)
        }
    }
    
    func retrieveRecords () -> [Record] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do{
            let records = try decoder.decode([Record].self, from: data)
            return records
        }
        catch {
            print (error)
            return []
        }
    }
}
