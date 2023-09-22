//
//  RoomView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomView: View {
    
    @StateObject var viewModel: RoomViewModel = RoomViewModel()
    @EnvironmentObject var userManager: UserManager

    @Binding var room: Room
    @Binding var showRoom: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text(room.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding([.top, .leading], 8)
                Spacer()
                Button {
                    showRoom.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                }.padding([.top, .trailing], 8)
            }
            
            ScrollView(.horizontal){
                LazyHStack{
                    if let myUser = userManager.currentUser {
                        Button {
                            viewModel.taskImporter.toggle()
                            viewModel.userSelected = UserInRoom(userName: myUser.name, userId: myUser.id, score: room.fetchScoreById(id: myUser.id), importedTasks: room.fetchUserById(id: myUser.id).importedTasks)
                        } label: {
                            UserListElementView(userName: myUser.name, userScore: room.fetchScoreById(id: myUser.id))
                        }
                    }
                    
//                    ForEach(room.users, id: \.self) { user in
//                        if user.userId != userManager.currentUser?.id{
//                        Button {
//                            viewModel.tasksFromAUser.toggle()
//                            viewModel.userSelected = user
//                        } label: {
//                            UserListElementView(userName: user.userName, userScore: room.fetchScoreById(id: user.userId))
//                        }.buttonStyle(.plain)
//                    }
//                  }
                }
            }
            .frame(height: 60)
            Divider()
            
            ZStack(alignment: .top){
                ScrollView{
                    
                    Spacer().frame(height: 200)
                    
                    ForEach(viewModel.feed, id: \.self){ taskCompleted in
//                        TaskCompletionPost(picture: taskCompleted.picture, taskName: taskCompleted.taskName, users: room.users)
                    }
                }
                
                Button("Upload Task Completion Proof") {
                    viewModel.pickingTaskToComplete.toggle()
                }.padding(.vertical, 6)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .foregroundColor(Color("grayBackGround"))
                    )
            }
        }
        

        .sheet(isPresented: $viewModel.pickingTaskToComplete) {
            let user = room.fetchUserById(id: userManager.currentUser?.id ?? "nada")
                ForEach(user.importedTasks, id: \.self){ userTask in
                    Button{
                        viewModel.takingPic.toggle()
                        viewModel.selectedTask = userTask
                    } label: {
                        Text(userTask.taskName)
                    }
                }
        }
        .sheet(isPresented: $viewModel.takingPic) {
            Camera(selectedImage: $viewModel.newPhoto, sourceType: .camera)

                .onDisappear{
                    viewModel.feed.insert(TaskCompletionModel(picture: viewModel.newPhoto, taskName: viewModel.selectedTask.taskName, approvals: []), at: 0)
                }
        }
        
        .sheet(isPresented: $viewModel.tasksFromAUser) {
            if let userSelected = viewModel.userSelected {
                ForEach(userSelected.importedTasks, id: \.self){ task in
                    HStack{
                        Text(task.taskName)
                        Image(systemName: task.approved ? "checkmark.square" : "square")
                    }
                }
            }
        }
        
        .sheet(isPresented: $viewModel.taskImporter) {
            if let userSelected = viewModel.userSelected {
                ForEach(userManager.userTasks, id: \.self){ task in
                    if room.containsTask(id: userSelected.userId, taskId: task.id){
                        let importedTask = room.importedFromId(userId: userSelected.userId, taskId: task.id)
                        
                        HStack{
                            Image(uiImage: importedTask.taskIcon)
                                .padding(.leading, 8)
                            Text(importedTask.taskName)
                            Spacer()
                            Image(systemName: importedTask.approved ? "checkmark.square" : "square")
                                .padding(.trailing, 8)
                        }
                        .padding(.vertical, 12)
                        .background(Color("grayBackGround"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: -1)
                                .stroke(.primary)
                        )
                        
                    } else {
                        Button {
                            room.importTask(task: task, userId: userSelected.userId)
                        } label: {
                            HStack{
                                Image(/*uiImage: task.icon*/ systemName: "book.circle")
                                    .padding(.leading, 8)
                                Text(task.taskName)
                                Spacer()
                                
                                Image(systemName: "plus")
                                    .padding(.trailing, 8)
                            }.padding(.vertical, 4)
                                .background(Color("antiPrimary"))
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .inset(by: -1)
                                        .stroke(.blue)
                                )
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        
                    }
                }
            }
        }
        
    }
}

//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomView()
//    }
//}
