//
//  RoomViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

final class RoomCreationManager: ObservableObject {

    @Published var room: Room = Room()
    @Published var points: Int = 3
    @Published var penalties: Int = 2
    @Published var pointsPicker: Bool = false
    @Published var penalityPicker: Bool = false
    @Published var maxHour: Int = 24
    @Published var hourPicker: Bool = false
    
}
