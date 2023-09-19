//
//  TaskListViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 15/09/23.
//

import Foundation
import SwiftUI

final class TaskListManager: ObservableObject {
    
    
    
    @Published var tasks: [TaskModel] = [/*TaskModel(taskName: "Cappihilation", selectedPeriod: .weekly, monthDays: nil, weekDays: [.monday, .wednesday], dueDate: nil), TaskModel(taskName: "Kill a Capibara", selectedPeriod: .weekly, monthDays: nil, weekDays: [.wednesday, .friday, .thursday], dueDate: Date())*/]
    
    @Published var creating: Bool = false
    @Published var taskToCreate: TaskModel = TaskModel()
    
    func taskCreation(){
        self.creating = true
        self.taskToCreate = TaskModel()
    }
    
    func deleteTask(taskToDelete: TaskModel){
        
        Task {
            do{
                try await CloudKitService.shared.delete(data: taskToDelete)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        self.tasks.removeAll { task in
            task.id == taskToDelete.id
        }
    }
    
}
