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
    let currentUserId: String
    @Binding var toggleCam: Bool
    
//    init(userId: String, picture: UIImage, taskName: String, approvals: [String] = [], users: [UserInRoom], currentUserId: String) {
//        postModel = TaskCompletionModel(userId: userId, picture: picture, taskName: taskName, approvals: approvals)
//        self.users = users
//        self.currentUserId = currentUserId
//
//    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                Text(postModel.taskName)
                HStack{
                    Image(uiImage: postModel.picture)
                        .frame(width: 200, height: 356)
                    VStack{
                        ForEach(users, id: \.self){ user in
                            if user.userId != currentUserId {
                                HStack(alignment: .top){
                                    Text(user.userName)
                                        .font(.footnote)
                                        .fontWeight(.light)
                                    Image(systemName: postModel.approvals.contains(user.userId) ? "checkmark.square" : "square")
                                }
                            }
                        }
                    }
                }
            }
            if currentUserId != postModel.userId {
                if !postModel.approvals.contains(currentUserId) {
                    HStack {
                        Button("Approve") {
                            postModel.approvals.append(currentUserId)
                        }.frame(width: 150, height: 36)
                            .foregroundColor(.green)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .foregroundColor(Color("grayBackGround"))
                            )
                        Button("Deny") {
                            
                        }.frame(width: 150, height: 36)
                            .foregroundColor(.red)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .foregroundColor(Color("grayBackGround"))
                            )
                    }
                }
            } else {
                Button("Retake Photo") {
                    
                }.frame(width: 300, height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color("grayBackGround"))
                    )
            }
            Divider()
        }
         .padding(.horizontal, 26)
    }
}

struct TaskCompletionPost_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionPost(postModel: TaskCompletionModel(userId: "george", picture: UIImage(), taskName: "task default", approvals: ["123", "george"]), users: [UserInRoom(userName: "maic", userId: "123", score: 0, importedTasks: [])], currentUserId: "george", toggleCam: .constant(false))
    }
}
