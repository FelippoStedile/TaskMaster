//
//  RoomViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

struct ImportedTaskModel: Hashable {
    var taskId: String
    var taskIcon: UIImage
    var taskName: String
    var picture: UIImage
    var approved: Bool
    var upvotes: Int
    
}

struct UserInRoom: Hashable {
    var userName: String
    var userId: String
    var score: Int
    var importedTasks: [ImportedTaskModel]
    
}

final class RoomViewModel: ObservableObject {

    @Published var newPhoto: UIImage = UIImage()
    @Published var pickingTaskToComplete: Bool = false
    @Published var selectedTask: ImportedTaskModel = ImportedTaskModel(taskId: "", taskIcon: UIImage(systemName: "book.circle")!, taskName: "", picture: UIImage(), approved: false, upvotes: 0)
    @Published var takingPic: Bool = false
    @Published var tasksFromAUser: Bool = false
    @Published var userSelected: UserInRoom?
    @Published var taskImporter: Bool = false
    @Published var users: [UserInRoom] = []
    @Published var currentUser: UserInRoom?
    @Published var feed: [TaskCompletionModel] = []
    
    
    func fetchUsersInRoom(userIds: [String]) {
        
        userIds.forEach { userId in
            
            #warning("pegar todos os usuarios da sala, passalos para a estrutura UserInRoom e colocar no vetor aqui de users")
            //let user = cloudkit.Shared.pegaUser
            //var tasksImported = []
            //user.tasks.forEach { taskID in
            //cloudKit.shared.pegaFetchTasks
            
            //tasksImported.append(ImportedTaskModel(taskId: <#T##String#>, taskIcon: <#T##UIImage#>, taskName: <#T##String#>, picture: <#T##UIImage#>, approved: <#T##Bool#>, upvotes: <#T##Int#>))
            
            //}
            
            //let userFetched = UserInRoom(userName: <#T##String#>, userId: <#T##String#>, score: <#T##Int#>, importedTasks: tasksImported)
            //viewModel.users.append(<#T##newElement: UserInRoom##UserInRoom#>)
            
            
        }
        
    }
    
    func setCurrentUser(myId: String) {
        self.currentUser = fetchUserById(id: myId)
        
    }
    
    func fetchUserById (id: String ) -> UserInRoom? {
        let userToSearch = users.first(where: {$0.userId == id})
    
        return userToSearch
    }
    
    func fetchScoreById(id: String) -> Int {
      //  let userInRoom = users.first(where: {$0.userId == id})
        return 0//userInRoom?.score ?? 0
    }
    
    func containsTask(taskId: String) -> Bool {
        var value = false
        if let tasks = currentUser?.importedTasks {
            tasks.forEach { task in
                if task.taskId == taskId{
                    value = true
                }
            }
            return value
        }
        return value
    }
    
    func importTask(task: TaskModel) {
        let taskToImport = ImportedTaskModel(taskId: task.id, taskIcon: UIImage(systemName: "book.circle")!, taskName: task.taskName, picture: UIImage(), approved: false, upvotes: 0)
        
        self.currentUser?.importedTasks.append(taskToImport)
        
//        self.users.forEach { user in
//            if user.userId == currentUser?.userId {
//                user.importedTasks.append(taskToImport)
//            }
//        }//n rola aqui pq n pego o verdadeiro vetor aparentemente

        #warning("fazer update do banco aqui, pra mudar qnd o cara importa uma task, ou, fazer outra funcao pra ser chamada qnd ele sai da sala e faz o update só uma vez daí")
        
    }

    func addPhoto(userId: String) {
        
        self.feed.insert(TaskCompletionModel(userId: userId, picture: self.newPhoto, taskName: self.selectedTask.taskName, approvals: []), at: 0)
    }
}
