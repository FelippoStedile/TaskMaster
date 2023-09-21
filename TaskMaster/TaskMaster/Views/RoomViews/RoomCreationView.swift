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
                ForEach(userManager.userTasks, id: \.self){ task in
                        Button {
                            createRoom(startingTask: task)
                        } label: {
                            HStack{
                                Text(task.taskName)
                                Image(systemName: "plus")
                            }
                        }
                }
            }
    }
    
    func createRoom(startingTask: TaskModel) {
        
        let taskToImport = ImportedTaskModel(taskId: startingTask.id, taskName: startingTask.taskName, picture: UIImage(), approved: false, upvotes: 0)
        
        if let me = userManager.currentUser {
            let room = Room(id: UUID().uuidString, name: roomName, tasksID: [""], memberID: [""], users: UserInRoom(userName: me.name , userId: me.id, score: 0, importedTasks: [taskToImport]), lastTaskAdd: nil, password: "" , creatorId: "", rewardCompletion: 3, penaltyFail: 2, maxEditTime: 0)
            
            
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
