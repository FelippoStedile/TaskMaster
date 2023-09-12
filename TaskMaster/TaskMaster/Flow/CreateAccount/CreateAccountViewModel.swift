//
//  CreateAccountViewModel.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import SwiftUI

final class CreateAccountViewModel: ObservableObject {
    @Published var name: String = ""
    
    
    func getUserToCreate() -> User {
        let user = User(id: "-1", name: name, roomIDs: [""], xp: 0, record: nil)
        return user
    }
    
}
