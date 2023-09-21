//
//  RoomViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

final class RoomViewModel: ObservableObject {

    @Published var newPhoto: UIImage = UIImage()
    @Published var pickingTaskToComplete: Bool = false
    @Published var selectedTask: TaskModel = TaskModel()
    @Published var takingPic: Bool = false
   
    @Published var feed: [TaskCompletionModel] = []
    
}
