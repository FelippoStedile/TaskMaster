//
//  UserManager.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import SwiftUI

@MainActor
final class UserManager: ObservableObject {
    
    let serviceProvider: RemoteServiceProvider
    
    @Published var creating: Bool = false
    @Published var taskToCreate: TaskModel = TaskModel()
    
    
    
    @Published var currentUser: User?
    
    @Published var userTasks: [TaskModel] = []
    @Published var userRooms: [Room] = []
    
    var userID: String?
    
    @Published var showAlertError: Bool = false
    @Published var errorMessage: String = ""

    
    init(serviceProvider: RemoteServiceProvider) {
        self.serviceProvider = serviceProvider
        Task {
            do {
                let userID =  try await serviceProvider.getUserRecordId()
                fetchUserInfo(userID: userID)
            } catch {
                handleError(error: error)
            }

        }
        
    }
    
    private func handleError(error: Error){
        errorMessage = error.localizedDescription
        showAlertError = true
    }
        
    private func handleError(error: Error, origin: String = #function) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
            self.showAlertError = true
        }
        print("Error on: \(origin): \(errorMessage)")
    }
    
    func getAllUserTasks() {
        guard let userID = currentUser?.id else {
            print("Error on \(#function): UserID is nil")
            return
        }
        let predicate = NSPredicate(format: "ownerID == %@", userID)
        CloudKitService.shared.fetchFilteredData(predicate: predicate, type: TaskModel.self) { result in
            switch result {
            case .success(let userTasks):
                DispatchQueue.main.async {
                    self.userTasks = userTasks
                }
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    func getAllUserRooms() {
        guard let userID = currentUser?.id else {
            print("Error on \(#function): UserID is nil")
            return
        }
        let predicate = NSPredicate(format: "creatorId == %@", userID)
        CloudKitService.shared.fetchFilteredData(predicate: predicate, type: Room.self) { result in
            switch result {
            case .success(let userRooms):
                DispatchQueue.main.async {
                    self.userRooms = userRooms
                }
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
}

extension UserManager {
    
    private func fetchUserInfo(userID: String) {
        serviceProvider.fetchCurrentUser(type: User.self, userID: userID) { result in
            switch result {
            case .success(let user):
                self.currentUser = user
                self.getAllUserTasks()
                self.getAllUserRooms()
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    func createUser(user: User) {
        Task {
            var tempUser = user
            tempUser.id = serviceProvider.currentUserID
            do {
                try await serviceProvider.createUser(user: tempUser)
                self.currentUser = user
            } catch {
                handleError(error: error)
            }
        }
    }
    
    func createRoom(room: Room){
        Task {
            do {
                var newRoom = room
                newRoom.creatorId = currentUser!.id
                let roomRecrod = try  await serviceProvider.saveData(data: newRoom)
                newRoom.record = roomRecrod
                self.userRooms.append(newRoom)
            } catch {
                print("Error on \(error.localizedDescription)")
            }
        }
    }
    
}

extension UserManager {
    
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
        
        self.userTasks.removeAll { task in
            task.id == taskToDelete.id
        }
    }

}
