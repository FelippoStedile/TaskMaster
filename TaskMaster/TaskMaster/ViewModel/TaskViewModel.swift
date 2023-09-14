//
//  TaskViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import Foundation
import SwiftUI

final class TaskManager: ObservableObject {
    @Published var taskName: String = ""
    @Published var selectedPeriod: Period = .weekly
    @Published var selectedWeek: [Week]?
    @Published var monthDays: [Int]?
    @Published var dueDate: Date?
    
    //@Published var task: TaskModel
    
    @Published var dueDate2: Date = Date() {
        didSet {
            self.dueDate = self.dueDate2
        }
    }
    
    @Published var dueBool: Bool {
        didSet {
            if dueBool == true {
                if self.dueDate == nil {
                    self.dueDate = Date()
                }
            }
        }
    }
    
    @Published var showCalendar: Bool = false
    @Published var deleteAlert: Bool = false
    
    let weekDays: [Week] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    init(dueBool: Bool) {
        self.dueBool = dueBool
    }
    
    
    func selectWeek(day: Week){
        if var selectedWeek = self.selectedWeek {
            if selectedWeek.contains(day) {
                self.selectedWeek = selectedWeek.filter {$0 != day}
            } else {
                selectedWeek.append(day)
                self.selectedWeek = selectedWeek
            }
        } else {
            self.selectedWeek = [day]
        }
    }
    
    func selectMonth(day: Int){
        if var monthDays = self.monthDays {
            if (monthDays.contains(day)) {
                self.monthDays = monthDays.filter{$0 != day}
            } else {
                if (monthDays.count < 10) {
                    monthDays.append(day)
                    monthDays.sort()
                    self.monthDays = monthDays
                }
            }
        } else {
            self.monthDays = [day]
        }
    }
    
    func containsWeekDay(day: Week) -> Color {
        if let selectedWeek = self.selectedWeek {
            if selectedWeek.contains(day) {
                return .blue
            } else {
                return .primary
            }
        }
        return .primary
    }
    
    func containsMonthDay(day: Int) -> Color {
        if let monthDays = self.monthDays {
            if monthDays.contains(day) {
                return .blue
            } else {
                return .primary
            }
        }
        return .primary //só pra vai q buga, a gnt estranha e percebe q é possível bugar
    }
    
    func upload() -> (name: String, period: Period, weekDays: [Week]?, monthDays: [Int]?, dueDate: Date?) {
        
        if self.selectedPeriod == .weekly {
          self.monthDays = nil
        } else {
         self.selectedWeek = nil
        }
        if self.selectedWeek == [] {
            self.selectedWeek = nil
        }
        if self.monthDays == [] {
            self.monthDays = nil
        }
        if !self.dueBool {
         self.dueDate = nil
        }
        
        //manda pro cloud
        
        return (taskName, selectedPeriod, selectedWeek, monthDays, dueDate)
        
    }
    
    func cancel(){

    }
    
    func toggleDelete(){
        self.deleteAlert.toggle()
    }
    
    func delete(){
        
    }
}
