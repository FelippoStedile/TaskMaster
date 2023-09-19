//
//  UserManager.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import SwiftUI

@MainActor
final class UserManager: ObservableObject {
    
    let serviceProvider: RemoteServiceProvider
    
    @Published var currentUser: User?
    
    private var userID: String?
    
    @Published var showAlertError: Bool = false
    @Published var errorMessage: String = ""
    
    init(serviceProvider: RemoteServiceProvider) {
        self.serviceProvider = serviceProvider
        Task {
            do {
                let userID =  try await serviceProvider.getUserRecordId()
                fetchUserInfo(userID: userID)

            } catch {
                handleError(error: error)
            }

        }
        
    }
        
    private func handleError(error: Error, origin: String = #function) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
            self.showAlertError = true
        }
        print("Error on: \(origin): \(errorMessage)")
    }
}

extension UserManager {
    
    private func fetchUserInfo(userID: String) {
        serviceProvider.fetchCurrentUser(type: User.self, userID: userID) { result in
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

