//
//  MasterModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import Foundation

struct MasterModel {
    var masterName: String
    var masterID: String
    var masterTasks: [TaskModel] = []
    var masterRoomIDs: [String] = []
    var masterXP: Int = 0
}
