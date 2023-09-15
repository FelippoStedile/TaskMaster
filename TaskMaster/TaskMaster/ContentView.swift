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
        NavigationStack{
            VStack {
                TaskListView()
                //Text(userManager.currentUser?.name ?? "Não chegou")
                
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
