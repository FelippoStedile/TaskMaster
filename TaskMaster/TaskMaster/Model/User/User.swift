//
//  MasterModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import CloudKit

struct User: Recordable {
    
    var id: String
    var name: String = ""
    var tasks: [String] = []
    var roomIDs: [String] = []
    var xp: Int = 0
    var record: CKRecord?
    
    init(id: String, name: String, roomIDs: [String], xp: Int, record: CKRecord?) {
        self.id = id
        self.name = name
        self.roomIDs = roomIDs
        self.xp = xp
        self.record = record
    }
    
    init?(record: CKRecord) {
        if let id = record["id"] as? String {
            self.id = id
        } else {
            return nil
        }
        
        if let name = record["name"] as? String {
            self.name = name
        }
        
        if let roomIDs = record["roomIDs"] as? [String] {
            self.roomIDs = roomIDs
        }
        
        if let xp = record["xp"] as? Int {
            self.xp = xp
        }
    }
}
