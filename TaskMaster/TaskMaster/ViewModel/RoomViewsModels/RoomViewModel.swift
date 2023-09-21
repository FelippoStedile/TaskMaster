//
//  RoomViewModel.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import Foundation
import SwiftUI

final class RoomManager: ObservableObject {

    @Published var newPhoto: UIImage = UIImage()
    @Published var takingPic: Bool = false
   
    @Published var feed: [TaskCompletionModel] = []
    
}
