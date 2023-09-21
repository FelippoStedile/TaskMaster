//
//  ImportedTaskModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 21/09/23.
//

import Foundation
import SwiftUI

struct ImportedTaskModel: Hashable {
    var taskId: String
    var taskName: String
    var picture: UIImage
    var approved: Bool
    var upvotes: Int
    
}
