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
    
    var body: some View {
        ScrollView{
            VStack{
                //ForEach{
                TaskView(editing: .constant(false))
                
                TaskView(editing: .constant(false))
                
                TaskView(editing: .constant(false))
                //}
                
                
                if creating {
                    TaskView(editing: $creating)
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
