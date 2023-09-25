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
                            //viewModel.userSelected = viewModel.currentUser
                            if let selectedMe = viewModel.fetchUserById(id: myUser.id) {
                                viewModel.userSelected = selectedMe
                                viewModel.taskImporter.toggle()
                            }
                        } label: {
                            UserListElementView(userName: myUser.name, userScore: viewModel.fetchScoreById(id: myUser.id))
                        }
                    }
                    
                    ForEach(viewModel.users, id: \.self) { user in
                        if user.userId != userManager.currentUser?.id{
                        Button {
                            viewModel.userSelected = user
                            viewModel.tasksFromAUser.toggle()
                        } label: {
                            UserListElementView(userName: user.userName, userScore: viewModel.fetchScoreById(id: user.userId))
                        }.buttonStyle(.plain)
                    }
                  }
                }
            }
            .frame(height: 60)
            Divider()
            
            ZStack(alignment: .top){
                ScrollView{
                    
                    Spacer().frame(height: 200)
                    
                    ForEach(viewModel.feed, id: \.self){ taskCompleted in
                        TaskCompletionPost(picture: taskCompleted.picture, taskName: taskCompleted.taskName, users: viewModel.users)
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
            if let userTasks = viewModel.currentUser?.importedTasks {
                ForEach(userTasks, id: \.self){ task in
                    if !task.approved {
                        Button{
                            viewModel.takingPic.toggle()
                            viewModel.selectedTask = task
                        } label: {
                            HStack{
                                Image(uiImage: task.taskIcon)
                                    .padding(.leading, 8)
                                Text(task.taskName)
                                Spacer()
                                Image(systemName: "camera")
                                    .padding(.trailing, 8)
                            }
                            .padding(.vertical, 12)
                            .background(Color("grayBackGround"))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: -1)
                                    .stroke(Color.primary)
                            )
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.takingPic) {
            Camera(selectedImage: $viewModel.newPhoto, sourceType: .camera)

                .onDisappear{
                    if let id = userManager.currentUser?.id {
                        viewModel.addPhoto(userName: id)
                    }
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
            if let userSelected = viewModel.currentUser {
                ForEach(userSelected.importedTasks, id: \.self){ task in
                        HStack{
                            Image(uiImage: task.taskIcon)
                                .padding(.leading, 8)
                            Text(task.taskName)
                            Spacer()
                            Image(systemName: task.approved ? "checkmark.square" : "square")
                                .padding(.trailing, 8)
                        }
                        .padding(.vertical, 12)
                        .background(Color("grayBackGround"))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: -1)
                                .stroke(Color.primary)
                        )
                        
                    }
                ForEach(userManager.userTasks, id: \.self){ task in
                    if !viewModel.containsTask(taskId: task.id){
                        Button {
                            viewModel.importTask(task: task)
                            #warning("aquele role de ter [taskId: userId] n lemrbo se era na sala, se for é aqui que faz")
                            room.tasksID.append(task.id /*, userManagar.currentUser.userId */)
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
                                        .stroke(Color.accentColor)
                                )
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 10)
                        
                    }
                }
            }
        }
        .onAppear(){
            viewModel.fetchUsersInRoom(userIds: room.memberID)
            if let myId = userManager.currentUser?.id {
                viewModel.setCurrentUser(myId: myId)
            }
        }
    }
}

//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomView()
//    }
//}
