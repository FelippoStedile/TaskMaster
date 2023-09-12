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
    var tasksID:  [String] = []
    var memberID: [String] = []
    var lastTaskAdd: Date?
    
    var record: CKRecord?
    
    init?(record: CKRecord) {
        if let id = record["id"] as? String {
            self.id = id
        } else {
            return nil
        }
        
        if let name = record["name"] as? String {
            self.name = name
        } else {
            return nil
        }
    }
}
