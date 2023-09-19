//
//  TaskListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

struct TaskItemView: View {
    var taskName: String
    var taskDueDate: Date
    //var weekDays: [Week]
    var monthDays: [Int]
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(systemName: "book.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Text("Task Name")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            HStack {
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("D")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("S")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("T")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("Q")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("Q")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("S")
                }
                ZStack{
                    Circle().stroke()
                        .frame(height: 20)
                    Text("S")
                }
            }
            HStack{
                ProgressView(value:0.1)
                Text("10/09")
            }
        }
    }
}
struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(taskName: "Oi", taskDueDate: Date(), monthDays: [10, 20])
    }
}
