//
//  TaskModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import Foundation
import SwiftUI

struct TaskModel {
    var name: String
    var weekDaysOn: Int8 //bit 1 = domingo, 2 = segunda... 7 = sabado, 0 = repetir proxima semana? (só pensando em alguma utilidade pra ele mesmo kk
    var icon: Image //UIImage sla
    var monthDaysOn: [Date]
    var dueDate: Date
}
