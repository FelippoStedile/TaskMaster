//
//  TaskCompletionModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

final class TaskCompletionModel: ObservableObject {

    @Published var picture: UIImage = UIImage()
    @Published var taskName: String = "Task Name"
    @Published var approvals: [Bool] = []
    
}
