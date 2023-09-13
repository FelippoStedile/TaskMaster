//
//  TaskModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI
import CloudKit

struct TaskModel: Recordable {
    
    var id: String
    var record: CKRecord?
    
    var taskName: String
    var icon: Image = Image(systemName:"book.circle") //Data não mockada
    var selectedPeriod: Period
    var monthDays: [Int]?
    var weekDays: [Week]?
    var dueDate: Date?
    
    init?(record: CKRecord) {
        if let id = record["id"] as? String {
            self.id = id
        } else {
            return nil
        }
        
        if let taskName = record["taskName"] as? String {
            self.taskName = taskName
        } else {
            self.taskName = "Nameless Task"
        }
        
//        if let icon = record["icon"] as? Image { //ou UIImage
//            self.icon = icon
//        } else {
//            self.icon = Image(systemName: "book.circle")
//        }
        
        if let selectedPeriod = record["selectedPeriod"] as? String, let period = Period(rawValue: selectedPeriod) {
            self.selectedPeriod = period
        } else {
            self.selectedPeriod = .weekly
        }
        
        if let monthDays = record["monthDays"] as? [Int] {
            self.monthDays = monthDays
        }
        
        if let weekDays = record["weekDays"] as? [Week] {
            self.weekDays = weekDays
        }
        
        if let dueDate = record["dueDate"] as? Date {
            self.dueDate = dueDate
        }
        
    }

    

}
