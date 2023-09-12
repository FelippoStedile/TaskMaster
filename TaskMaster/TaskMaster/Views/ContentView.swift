//
//  ContentView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink {
                    TaskItemView(taskName: "Matar a cappy", taskDueDate: Date(), monthDays: [23, 24])
                } label: {
                    Text("Task List View")
                }
                
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
