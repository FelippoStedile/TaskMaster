//
//  UserInRoomModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 21/09/23.
//

import Foundation

struct UserInRoom: Hashable {
    var userName: String
    var userId: String
    var score: Int
    var importedTasks: [ImportedTaskModel]
    
}
