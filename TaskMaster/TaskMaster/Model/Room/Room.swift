//
//  Room.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import CloudKit

struct Room: Recordable {
    var id: String
    var name: String
    var tasksID: [String] = []
    var memberID: [String] = []
    var lastTaskAdd: Date?
    var password: String = ""
    var creatorId: String = ""
    var rewardCompletion: Int = 3
    var penaltyFail: Int = 2
    var maxEditTime: Int = 0
    
    var record: CKRecord?
    
    init() {
        self.id = UUID().uuidString
        self.name = ""
    }
    
    init?(record: CKRecord) {
        guard
            let id = record["id"] as? String,
            let name = record["name"] as? String
        else {
            return nil
        }
        
        self.id = id
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
}
