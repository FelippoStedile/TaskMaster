//
//  CreateAccountView.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 12/09/23.
//

import SwiftUI

struct CreateAccountView: View {
    
    @ObservedObject var userManager: UserManager
    @StateObject var viewModel: CreateAccountViewModel = CreateAccountViewModel()
    
    init() {
        let serviceProvider: RemoteServiceProvider = CloudKitService.shared
        userManager = UserManager(serviceProvider: serviceProvider)
    }
    
    var body: some View {
        VStack {
            TextField("name", text: $viewModel.name)
            
            Button {
                let user = viewModel.getUserToCreate()
                userManager.createUser(user: user)
            } label: {
                Text("Create Account")
            }

        }
    }
}

