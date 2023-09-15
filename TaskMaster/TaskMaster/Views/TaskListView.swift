//
//  TaskListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import SwiftUI

struct taskMock {
    
}

struct TaskListView: View {
    @StateObject var viewModel = TaskListManager()
    var body: some View {
        ScrollView{
            VStack{
                ForEach($viewModel.tasks, id: \.id){ task  in
                    TaskView(task: task)
                        .environmentObject(viewModel)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                        )
                }
                HStack {
                    if !viewModel.creating{
                        Button{
                            viewModel.taskCreation()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                                Text("Create")
                                    .font(.system(size: 25))
                                    .foregroundColor(.accentColor)
                                    .padding(.vertical, 8)
                            }
                        }.buttonStyle(.plain)
                    }
                }
            }.padding(.horizontal, 8)
        }.sheet(isPresented: $viewModel.creating, onDismiss: {
            if viewModel.taskToCreate.taskName.isEmpty {
                print("ta aqui")
                viewModel.deleteTask(id: viewModel.taskCreationTemplate.id)
            } else {
                viewModel.tasks.append(viewModel.taskToCreate)
                viewModel.taskToCreate = viewModel.taskCreationTemplate
            }
        }) {
            //fazer sem o binding no template
            TaskView(task: $viewModel.taskToCreate, editing: true)
        }.presentationDetents([.medium])
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
