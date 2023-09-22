//
//  RoomCreationView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomCreationView: View {
    
    @StateObject var viewModel: RoomCreationManager = RoomCreationManager()
    @EnvironmentObject var userManager: UserManager
    
    @Binding var showRoomCreation: Bool
    
    @State private var roomName = ""
    @State private var roomPassword = ""
    @State private var creatorId = ""
    @State var taskSelection: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                Text("Create a Room")
                    .font(.title)
                
                TextField("Room Name", text: $roomName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Password", text: $roomPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button{
                    taskSelection.toggle()
                } label: {
                    Text("Create Room")
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(Color.primary)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
        .sheet(isPresented: $taskSelection) {
            VStack {
                Text("Import one of your tasks to track.")
                    .padding(.top, 32)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                    
                ForEach(userManager.userTasks, id: \.self){ task in
                    Button {
                        createRoom(startingTask: task)
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
                    }.padding(.horizontal, 8)
                        .padding(.vertical, 10)
                }
                Spacer()
            }
        }
    }
    
    func createRoom(startingTask: TaskModel) {
        
        let taskToImport = ImportedTaskModel(taskId: startingTask.id, taskIcon: UIImage(systemName: "book.circle")!, taskName: startingTask.taskName, picture: UIImage(), approved: false, upvotes: 0)
        
        let roomCode = CodeGenerator.shared.generate6DigitHash()
        print(roomCode)
        if let user = userManager.currentUser {
            let room = Room(id: UUID().uuidString, roomCode: roomCode, name: roomName, tasksID: [startingTask.id], memberID: [user.id], users: UserInRoom(userName: user.name , userId: user.id, score: 0, importedTasks: [taskToImport]), lastTaskAdd: nil, password: roomPassword , creatorId: user.id, rewardCompletion: 3, penaltyFail: 2, maxEditTime: 0)
            
            userManager.createRoom(room: room)
            showRoomCreation.toggle()
        }
        
    }
}

//struct RoomCreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCreationView()
//    }
//}
