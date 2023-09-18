//
//  TaskViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import Foundation
import SwiftUI

final class TaskManager: ObservableObject {
    
    @Published var task = TaskModel()
    
    @Published var dueDate2: Date = Date() {
        didSet {
            self.task.dueDate = self.dueDate2
        }
    }
    
    @Published var dueBool: Bool {
        didSet {
            if dueBool == true {
                if self.task.dueDate == nil {
                    self.task.dueDate = Date()
                }
            }
        }
    }
    
    @Published var showCalendar: Bool = false
    @Published var deleteAlert: Bool = false
    @Published var disableDelete: Bool = false
    
    let weekDays: [Week] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    init(dueBool: Bool) {
        self.dueBool = dueBool
    }
    
    
    func selectWeek(day: Week){
        if var selectedWeek = self.task.weekDays {
            if selectedWeek.contains(day) {
                self.task.weekDays = selectedWeek.filter {$0 != day}
            } else {
                selectedWeek.append(day)
                self.task.weekDays = selectedWeek
            }
        } else {
            self.task.weekDays = [day]
        }
    }
    
    func selectMonth(day: Int){
        if var monthDays = self.task.monthDays {
            if (monthDays.contains(day)) {
                self.task.monthDays = monthDays.filter{$0 != day}
            } else {
                if (monthDays.count < 10) {
                    monthDays.append(day)
                    monthDays.sort()
                    self.task.monthDays = monthDays
                }
            }
        } else {
            self.task.monthDays = [day]
        }
    }
    
    func containsWeekDay(day: Week) -> Color {
        if let selectedWeek = self.task.weekDays {
            if selectedWeek.contains(day) {
                return .blue
            } else {
                return .primary
            }
        }
        return .primary
    }
    
    func containsMonthDay(day: Int) -> Color {
        if let monthDays = self.task.monthDays {
            if monthDays.contains(day) {
                return .blue
            } else {
                return .primary
            }
        }
        return .primary
    }
    
    func progressValue() -> Float? {
        if let dueDate = task.dueDate {
            let numDays = Calendar.current.dateComponents([.day], from: Date(), to: dueDate).day
            
            if let numDaysUnwrap = numDays {
                let result = (1 - Float(numDaysUnwrap)/30.0)
                if result > 0 {
                    return result
                }
            }
        }
        return 0.0
    }
    
    func upload() -> (name: String, period: Period, weekDays: [Week]?, monthDays: [Int]?, dueDate: Date?) {
        
        if self.task.selectedPeriod == .weekly {
            self.task.monthDays = nil
        } else {
            self.task.weekDays = nil
        }
        if self.task.weekDays == [] {
            self.task.weekDays = nil
        }
        if self.task.monthDays == [] {
            self.task.monthDays = nil
        }
        if !self.dueBool {
            self.task.dueDate = nil
        }
        
//        let taskCreated = TaskModel(id: <#T##String#>, taskName: <#T##String#>, selectedPeriod: <#T##Period#>, monthDays: <#T##[Int]?#>, weekDays: <#T##[Week]?#>, dueDate: <#T##Date?#>)
//        Task {
//            CloudKitService.shared.saveData(data: taskCreated)
//
//        }
        #warning("Cloud aqui")
        
        return (task.taskName, task.selectedPeriod, task.weekDays, task.monthDays, task.dueDate)
        
    }
    
    func cancel(){
        if self.task.dueDate == nil {
            self.dueBool = false
        } else {
            self.dueBool = true
        }
    }
    
    func toggleDelete(){
        self.deleteAlert.toggle()
    }
    
    func delete() {
        
        self.task.dueDate = nil
        self.task.taskName = ""
        self.task.weekDays = nil
        self.task.monthDays = nil
        self.task.selectedPeriod = .weekly
    }
}
