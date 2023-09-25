//
//  TaskCompletionPost.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct TaskCompletionPost: View {
    
    @State var postModel: TaskCompletionModel
    @State var users: [UserInRoom]
    
    init(picture: UIImage, taskName: String, approvals: [String] = [], users: [UserInRoom]) {
       postModel = TaskCompletionModel(picture: picture, taskName: taskName, approvals: approvals)
        self.users = users
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(postModel.taskName)
            HStack{
                //Image(uiImage: postModel.picture)
                Rectangle()
                    .frame(width: 200, height: 356)
                VStack{
                    
                    ForEach(0..<3){ user in
                        HStack(alignment: .top){
                            Text("User name")
                                .font(.footnote)
                                .fontWeight(.light)
                            Image(systemName: "checkmark.square")
                        }
                    }
                }
            }
            Divider()
        } .padding(.horizontal, 26)
    }
}

struct TaskCompletionPost_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionPost(picture: UIImage(), taskName: "task default", users: [UserInRoom(userName: "maic", userId: "123", score: 0, importedTasks: [])])
    }
}
