//
//  TaskMasterApp.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

final class AppFlow {
    @Published var showModel1: Bool = false
}

@main
struct TaskMasterApp: App {
    
    @StateObject var userManager = UserManager(serviceProvider: CloudKitService.shared)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userManager)
//                .onOpenURL { <#URL#> in
//                    
//                }
        }
    }
}
