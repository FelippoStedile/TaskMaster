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
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: 100)
                HStack {
                    Picker("My Task", selection: $page) {
                        Text("My Tasks")
                            .tag(PageView.taskListView)
                    }
                    Picker("Rooms", selection: $page) {
                        Text("Room")
                            .tag(PageView.roomListView)
                    }
                }
                .pickerStyle(.segmented)
                
                if page == .taskListView {
                    TaskListView()
                        .environmentObject(userManager)
                } else {
                    RoomListView()
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
