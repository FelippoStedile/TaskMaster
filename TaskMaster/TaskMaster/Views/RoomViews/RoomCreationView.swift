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
                
                TextField("Creator ID", text: $creatorId)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: createRoom) {
                    Text("Create Room")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            
        }
    }
    
    func createRoom() {
        let room = Room(id: UUID().uuidString, name: roomName, tasksID: [""], memberID: [""], lastTaskAdd: nil, password: "" , creatorId: "", rewardCompletion: 3, penaltyFail: 2, maxEditTime: 0)
        
        userManager.createRoom(room: room)
        showRoomCreation.toggle()
        
    }
}

//struct RoomCreationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomCreationView()
//    }
//}
