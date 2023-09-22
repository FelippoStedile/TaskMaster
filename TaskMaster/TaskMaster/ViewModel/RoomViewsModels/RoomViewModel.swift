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
   
    @Published var feed: [TaskCompletionModel] = []
    
    
    func fetchUsersInRoom(userIds: [String]) {
        
        userIds.forEach { userId in
            
            //let user = cloudkit.Shared.pegaUser
            //var tasksImported = []
            //user.tasks.forEach { taskID in
            //cloudKit.shared.pegaFetchTasks
            
            //tasksImported.append(ImportedTaskModel(taskId: <#T##String#>, taskIcon: <#T##UIImage#>, taskName: <#T##String#>, picture: <#T##UIImage#>, approved: <#T##Bool#>, upvotes: <#T##Int#>))
            
            //}
            
            //let userFetched = UserInRoom(userName: <#T##String#>, userId: <#T##String#>, score: <#T##Int#>, importedTasks: tasksImported)
            //users.append(<#T##newElement: UserInRoom##UserInRoom#>)
        }
        
    }
    
}
