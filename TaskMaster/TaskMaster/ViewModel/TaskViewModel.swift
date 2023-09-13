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
    @Published var monthDays: [Int] = []
    @Published var selectedPeriod: Period = .weekly
    @Published var selectedWeek: [Week] = []
    @Published var dueDate: Date = Date()
    
    @Published var dueBool: Bool = true
    @Published var showCalendar: Bool = false
    
    let weekDays: [Week] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    
    
    func selectWeek(day: Week){
        self.selectedWeek.contains(day) ? self.selectedWeek = self.selectedWeek.filter {$0 != day} : self.selectedWeek.append(day)
    }
    
    func selectMonth(day: Int){
        if (self.monthDays.contains(day)) {
            self.monthDays = self.monthDays.filter{$0 != day}
        } else {
            if (self.monthDays.count < 10) {
                self.monthDays.append(day)
                self.monthDays.sort()
            }
        }
    }
    
    func containsWeekDay(day: Week) -> Color {
        if selectedWeek.contains(day) {
            return .blue
        } else {
            return .primary
        }
    }
    
    func containsMonthDay(day: Int) -> Color {
        if monthDays.contains(day) {
            return .blue
        } else {
            return .primary
        }
    }
    
}
