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
   // var tasks: [TaskModel] = []
    var roomIDs: [String] = []
    var xp: Int = 0
    var record: CKRecord?
    
    init?(record: CKRecord) {
        if let id = record["id"] as? String {
            self.id = id
        } else {
            return nil
        }
    }
}
