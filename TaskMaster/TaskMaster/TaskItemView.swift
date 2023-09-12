//
//  TaskListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

struct TaskItemView: View {
    var body: some View {
        VStack{
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
        }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView()
    }
}
