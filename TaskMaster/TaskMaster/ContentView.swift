//
//  ContentView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    var body: some View {
                TaskListView()
                //Text(userManager.currentUser?.name ?? "Não chegou")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
