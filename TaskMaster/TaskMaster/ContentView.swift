//
//  ContentView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

enum PageView {
    case taskListView
    case roomListView
}

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager
    @State var page: PageView = .taskListView
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Picker("My Task", selection: $page) {
                        Text("My Tasks")
                            .tag(PageView.taskListView)
                    }
                    Picker("Rooms", selection: $page) {
                        Text("Room")
                            .tag(PageView.roomListView)
                    }
                }.padding(.horizontal, 16)
                .pickerStyle(.segmented)
                
                if page == .taskListView {
                    TaskListView()
                        .environmentObject(userManager)
                } else {
                    RoomListView()
                        .environmentObject(userManager)

                }
            }.navigationTitle("Hello Felippo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
