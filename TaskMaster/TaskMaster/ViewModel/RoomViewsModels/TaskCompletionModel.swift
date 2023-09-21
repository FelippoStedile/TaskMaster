//
//  TaskCompletionModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

struct TaskCompletionModel: Hashable {

    var picture: UIImage = UIImage()
    var taskName: String = "Task Name"
    var approvals: [Bool] = []
    
    init() {
        self.picture = UIImage()
        self.approvals = []
        self.taskName = "Task Default Name"
    }
    
    init(picture: UIImage, taskName: String, approvals: [Bool]) {
        self.picture = picture
        self.taskName = taskName
        self.approvals = approvals
    }
    
}
