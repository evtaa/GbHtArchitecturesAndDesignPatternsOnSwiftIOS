//
//  CompositeTask.swift
//  CompositeProject
//
//  Created by Alexandr Evtodiy on 10.01.2021.
//

import Foundation
class CompositeTask: Task {
    internal init(name: String) {
        self.name = name
    }
    
    var name: String
    var subTasks: [Task] = []
    var countSubTasks: Int {
        get {
            return self.subTasks.count
        }
    }
    
   // func open(task: Task) {
   // }
}
