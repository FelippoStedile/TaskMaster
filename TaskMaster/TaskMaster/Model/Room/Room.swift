//
//  Room.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit
import UIKit

struct Room: Recordable, Hashable {
    var id: String
    var roomCode: String
    var name: String
    var tasksID: [String] = []
    var memberID: [String] = []
//    var users: [UserInRoom] = [UserInRoom(userName: "Maic", userId: "123", score: 12, importedTasks: [ImportedTaskModel(taskId: "task1", taskName: "FAcl", picture: UIImage(systemName: "square")!, approved: false, upvotes: 0)]),
//                               UserInRoom(userName: "X", userId: "234", score: 12, importedTasks: [ImportedTaskModel(taskId: "task2", taskName: "dificil", picture: UIImage(), approved: true, upvotes: 1), ImportedTaskModel(taskId: "task3", taskName: "Swift", picture: UIImage(), approved: false, upvotes: 0)])
//    ]
    var lastTaskAdd: Date?
    var password: String = ""
    var creatorId: String = ""
    var rewardCompletion: Int = 3
    var penaltyFail: Int = 2
    var maxEditTime: Int = 0
    
    var record: CKRecord?

    init(id: String, roomCode: String, name: String, tasksID: [String] = [], memberID: [String] = [], users: UserInRoom, lastTaskAdd: Date? = nil, password: String = "", creatorId: String = "", rewardCompletion: Int = 3, penaltyFail: Int = 2, maxEditTime: Int = 0) {
        self.id = id
        self.name = name
        self.roomCode = roomCode
        self.tasksID = tasksID
        self.memberID = memberID
       // self.users = [users]
        self.lastTaskAdd = lastTaskAdd
        self.password = password
        self.creatorId = creatorId
        self.rewardCompletion = rewardCompletion
        self.penaltyFail = penaltyFail
        self.maxEditTime = maxEditTime
    }
    
    init?(record: CKRecord) {
        guard
            let id = record["id"] as? String,
            let roomCode = record["roomCode"] as? String,
            let name = record["name"] as? String
        else {
            return nil
        }
                
        self.id = id
        self.roomCode = roomCode
        self.name = name
        
        if let tasksID = record["tasksID"] as? [String] {
            self.tasksID = tasksID
        }
        
        if let memberID = record["memberID"] as? [String] {
            self.memberID = memberID
        }
        
        if let lastTaskAdd = record["lastTaskAdd"] as? Date {
            self.lastTaskAdd = lastTaskAdd
        }
        
        if let password = record["password"] as? String {
            self.password = password
        }
        
        if let creatorId = record["creatorId"] as? String {
            self.creatorId = creatorId
        }
        
        if let rewardCompletion = record["rewardCompletion"] as? Int {
            self.rewardCompletion = rewardCompletion
        }
        
        if let penaltyFail = record["penaltyFail"] as? Int {
            self.penaltyFail = penaltyFail
        }
        
        if let maxEditTime = record["maxEditTime"] as? Int {
            self.maxEditTime = maxEditTime
        }
        
        self.record = record
    }
    
    func fetchScoreById(id: String) -> Int {
      //  let userInRoom = users.first(where: {$0.userId == id})
        return 0//userInRoom?.score ?? 0
    }
    
    func fetchUserById(id: String) -> UserInRoom {
      //  let userInRoom = users.first(where: {$0.userId == id})
        return  UserInRoom(userName: "gay", userId: "gay", score: 24, importedTasks: [])
    }
    
    func containsTask(id: String, taskId: String) -> Bool {
//        let userToSearch = users.first(where: {$0.userId == id})
//        if userToSearch != nil {
//            var value = false
//            userToSearch!.importedTasks.forEach { task in
//                if task.taskId == taskId{
//                    value = true
//                }
//            }
//            return value
//        }
        return false
    }
    
    func importedFromId(userId: String, taskId: String) -> ImportedTaskModel {
      //  let userInRoom = users.first(where: {$0.userId == userId})
        var taskToReturn: ImportedTaskModel = ImportedTaskModel(taskId: "deu ruim", taskIcon: UIImage(systemName: "book.circle")!, taskName: "deu Ruim", picture: UIImage(), approved: false, upvotes: 0)
//        if userInRoom != nil {
//            userInRoom!.importedTasks.forEach { task in
//                if task.taskId == taskId{
//                    taskToReturn = task
//                }
//            }
//            return taskToReturn
//        }
        return taskToReturn
    }
    
    func importTask(task: TaskModel, userId: String){
//        let taskToImport = ImportedTaskModel(taskId: task.id, taskName: task.taskName, picture: UIImage(), approved: false, upvotes: 0)
//        
//        var user = users.first(where: {$0.userId == userId})
//        
//        if user != nil {
//            
//            var listOfUsers = users.filter {$0 != user}
//            
//            user!.importedTasks.append(taskToImport)
//            
//            listOfUsers.append(user!)
//        }
        
    }
    
}
