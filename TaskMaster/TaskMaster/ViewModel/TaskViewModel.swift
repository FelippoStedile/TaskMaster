//
//  TaskViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import Foundation
import SwiftUI
import CloudKit

final class TaskManager: ObservableObject {
    
    @Published var task = TaskModel()
    
    @Published var dueBool: Bool {
        didSet {
            if dueBool == true {
                if self.task.dueDate == Date.distantPast {
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
        if self.task.weekDays != [-1] {
            if self.task.weekDays.contains(day.rawValue) {
                self.task.weekDays = self.task.weekDays.filter {$0 != day.rawValue}
            } else {
                self.task.weekDays.append(day.rawValue)
                self.task.weekDays.sort()
            }
        } else {
            self.task.weekDays = [day.rawValue]
        }
    }
    
    func selectMonth(day: Int){
        if self.task.monthDays != [-1] {
        if (self.task.monthDays.contains(day)) {
            self.task.monthDays = self.task.monthDays.filter{$0 != day}
            } else {
                if (self.task.monthDays.count < 10) {
                    self.task.monthDays.append(day)
                    self.task.monthDays.sort()
                }
            }
        } else {
            self.task.monthDays = [day]
        }
    }
    
    func containsWeekDay(day: Week) -> Color {
        if self.task.weekDays.contains(day.rawValue) {
            return .blue
        } else {
            return .primary
        }
    }
    
    func containsMonthDay(day: Int) -> Color {
        
        if self.task.monthDays.contains(day) {
            return .blue
        } else {
            return .primary
        }
    }
    
    func progressValue() -> Float? {
        let numDays = Calendar.current.dateComponents([.day], from: Date(), to: task.dueDate).day
            
            if let numDaysUnwrap = numDays {
                let result = (1 - Float(numDaysUnwrap)/30.0)
                if result > 0 {
                    return result
                }
            }
        return 0.0
    }
    
    func upload(completion: @escaping (TaskModel?) -> () ) {
        
        print("1")
        if self.task.selectedPeriod == .weekly {
            self.task.monthDays = [-1]
            print("2")

        } else {
            self.task.weekDays = [-1]
            
        }
        if self.task.weekDays == [] {
            self.task.weekDays = [-1]
        }
        print("3")

        if self.task.monthDays == [] {
            self.task.monthDays = [-1]
        }
        print("4")

        if !self.dueBool {
            self.task.dueDate = Date.distantPast
        }
        print("4")

        var taskCreated = TaskModel(id: UUID().uuidString, taskName: self.task.taskName, selectedPeriod: self.task.selectedPeriod, monthDays: self.task.monthDays, weekDays: self.task.weekDays, dueDate: self.task.dueDate)
        print("6")

                CloudKitService.shared.saveData(data: taskCreated) { result in
                    DispatchQueue(label: "vrau").async {
                        print("7")

                        switch result {
                        case .success(let record):
                            taskCreated.record = record
                            print("8")

                            completion(taskCreated)
                        case .failure(let error):
                            completion(nil)
                            print("9")

                            print("Error on \(#function): \(error.localizedDescription)")
                        }
                    }
                }

        
        
    }
    
    func update(record: CKRecord) -> TaskModel {
        
        if self.task.selectedPeriod == .weekly {
            self.task.monthDays = [-1]
        } else {
            self.task.weekDays = [-1]
        }
        if self.task.weekDays == [] {
            self.task.weekDays = [-1]
        }
        if self.task.monthDays == [] {
            self.task.monthDays = [-1]
        }
        if !self.dueBool {
            self.task.dueDate = Date.distantPast
        }
        
        let taskUpdated = TaskModel(id: self.task.id, taskName: self.task.taskName, selectedPeriod: self.task.selectedPeriod, monthDays: self.task.monthDays, weekDays: self.task.weekDays, dueDate: self.task.dueDate, record: record)
        
        Task {
            do{
                try await CloudKitService.shared.update(data: taskUpdated)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return taskUpdated
    }
    
    func cancel(){
        if self.task.dueDate == Date.distantPast {
            self.dueBool = false
        } else {
            self.dueBool = true
        }
    }
    
    func toggleDelete(){
        self.deleteAlert.toggle()
    }
    
    func delete() {
        
        self.task.dueDate = Date.distantPast
        self.task.taskName = ""
        self.task.weekDays = [-1]
        self.task.monthDays = [-1]
        self.task.selectedPeriod = .weekly
    }
}
