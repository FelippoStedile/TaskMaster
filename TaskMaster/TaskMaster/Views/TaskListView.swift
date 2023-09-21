//
//  TaskListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    ForEach($userManager.userTasks, id: \.id){ task  in
                        TaskView(task: task)
                            .environmentObject(userManager)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.blue)
                            )
                    }
                    
                }.padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
            Spacer()
            
            createTaskButton()

        }
        .sheet(isPresented: $userManager.creating, onDismiss: {
            if !userManager.taskToCreate.taskName.isEmpty {
                userManager.userTasks.append(userManager.taskToCreate)
            }
        }) {
            TaskView(task: $userManager.taskToCreate, editing: true)
                .padding(.horizontal, 12)
                .padding(.top, 16)
                .presentationDetents([.fraction(0.4)])
            Spacer()
        }
    }
    
    @ViewBuilder
    private func createTaskButton() -> some View {
        HStack {
            if !userManager.creating{
                Button{
                    userManager.taskCreation()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("grayBackGround"))
                        Text("Create Task")
                            .font(.system(size: 25))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 8)
                    }
                }.buttonStyle(.plain)
                    .frame(height: 50)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
