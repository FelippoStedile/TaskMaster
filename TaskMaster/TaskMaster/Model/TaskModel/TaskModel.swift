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
    var ownerID: String
    var record: CKRecord?
    
    var taskName: String
    var icon: Image = Image(systemName:"book.circle") //Data não mockada
    var selectedPeriod: Period
    var monthDays: [Int] = [-1]
    var weekDays: [Int] = [-1]
    var dueDate: Date = Date.distantPast
    
    init(id: String, ownerID: String, taskName: String, selectedPeriod: Period, monthDays: [Int], weekDays: [Int], dueDate: Date, record: CKRecord? = nil) {
        self.id = id
        self.ownerID = ownerID
        self.taskName = taskName
        self.selectedPeriod = selectedPeriod
        self.monthDays = monthDays
        self.weekDays = weekDays
        self.dueDate = dueDate
        self.record = record
    }
    
    init() {
        self.id = UUID().uuidString
        self.ownerID = ""
        self.taskName = ""
        self.selectedPeriod = .weekly
    }
    
    init?(record: CKRecord) {
        guard
            let id = record["id"] as? String,
            let ownerID = record["ownerID"] as? String
        else {
            return nil
        }
        
        self.id = id
        self.ownerID = ownerID
        
        if let taskName = record["taskName"] as? String {
            self.taskName = taskName
        } else {
            self.taskName = "Nameless Task"
        }
        
        // Adicione o código para recuperar o ícone da CKRecord se for relevante.
        
        if let selectedPeriod = record["selectedPeriod"] as? String,
           let period = Period(rawValue: selectedPeriod) {
            self.selectedPeriod = period
        } else {
            self.selectedPeriod = .weekly
        }
        
        if let monthDays = record["monthDays"] as? [Int] {
            self.monthDays = monthDays
        }
        
        if let weekDays = record["weekDays"] as? [Int] {
            self.weekDays = weekDays
        }
        
        if let dueDate = record["dueDate"] as? Date {
            self.dueDate = dueDate
        }
        
        self.record = record
    }
}


extension TaskModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(taskName)
    }
}
