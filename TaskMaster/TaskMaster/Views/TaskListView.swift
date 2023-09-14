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
    @State var creating: Bool = false
    @State var editing: Bool = false
    @State var editArray: [Bool] = [false, false, false]
    
    @State var task1 = TaskModel(id: "Cappihilation", taskName: "Cappihilation", selectedPeriod: .weekly, monthDays: nil, weekDays: [.monday, .wednesday], dueDate: nil)
    @State var task2 = TaskModel(id: "Kill a Capibara", taskName: "Kill a Capibara", selectedPeriod: .weekly, monthDays: nil, weekDays: [.wednesday, .friday, .thursday], dueDate: Date())
    
    @State var taskCreationTemplate = TaskModel()
    
    var body: some View {
        ScrollView{
            VStack{
                //ForEach{
                //                ZStack{
                //                    RoundedRectangle(cornerRadius: 6)
                //                        .foregroundColor(Color(red: 0, green: 1, blue: 1))
                
                TaskView(task: $task1, editing: $editArray[0])
                    .onTapGesture {
                        if editing == true {
                            editArray[0].toggle()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(red: 0, green: 0, blue: 1))
                    )
                //                }
                
                TaskView(task: $task2, editing: $editArray[1])
                    .onTapGesture {
                        if editing == true {
                            editArray[1].toggle()
                        }
                    }.background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(red: 0, green: 0, blue: 1))
                    )
                
                TaskView(task: $task1, editing: $editArray[2])
                    .onTapGesture {
                        if editing == true {
                            editArray[2].toggle()
                        }
                    }.background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(red: 0, green: 0, blue: 1))
                    )
                //}
                
                
                if creating {
                    TaskView(task: $taskCreationTemplate, editing: $creating)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color(red: 0, green: 0, blue: 1))
                        )
                }
                
                HStack {
                    if !editing && !creating{
                        Button{
                            creating.toggle()
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
                    
                    if !creating{
                        Button{
                            editing.toggle()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                                Text(editing ? "Done" : "Edit")
                                    .font(.system(size: 25))
                                    .foregroundColor(.accentColor)
                                    .padding(.vertical, 8)
                            }
                        }.buttonStyle(.plain)
                    }
                }
            }.padding(.horizontal, 8)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
