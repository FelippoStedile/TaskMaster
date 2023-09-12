//
//  MasterModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import Foundation

class MasterModel {
    var masterName: String
    var masterID: String
    var masterTasks: [TaskModel] = []
    var masterRoomIDs: [String] = []
    var masterXP: Int = 0
    
    init(masterName: String, masterID: String) {
        self.masterName = masterName
        self.masterID = masterID
    }
}
