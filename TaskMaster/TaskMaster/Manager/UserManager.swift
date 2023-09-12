//
//  UserManager.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import SwiftUI

final class UserManager: ObservableObject {
    
    let serviceProvider: RemoteServiceProvider
    
    @Published var currentUser: User?
    
    @Published var showAlertError: Bool = false
    @Published var errorMessage: String = ""
    
    init(serviceProvider: RemoteServiceProvider) {
        self.serviceProvider = serviceProvider
    }
        
    private func handleError(error: Error, origin: String = #function) {
        self.errorMessage = error.localizedDescription
        self.showAlertError = true
    }
}

extension UserManager {
    
    private func fetchUserInfo() {
        serviceProvider.fetchCurrentUser(type: User.self) { result in
            switch result {
            case .success(let user):
                self.currentUser = user
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    func createUser(user: User) {
        Task {
            var tempUser = user
            tempUser.id = serviceProvider.currentUserID
            do {
                try await serviceProvider.createUser(user: tempUser)
                self.currentUser = user
            } catch {
                handleError(error: error)
            }
        }
    }
}

