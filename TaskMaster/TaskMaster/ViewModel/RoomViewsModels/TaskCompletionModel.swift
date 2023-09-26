//
//  TaskCompletionModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

struct TaskCompletionModel: Hashable {

    var userId: String = ""
    var picture: UIImage = UIImage()
    var taskName: String = "Task Name"
    var approvals: [String] = []
    
    init(userId: String, picture: UIImage, taskName: String, approvals: [String]) {
        self.userId = userId
        self.picture = picture
        self.taskName = taskName
        self.approvals = approvals
    }
    
}
