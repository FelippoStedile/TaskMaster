//
//  RoomElementView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 21/09/23.
//

import SwiftUI

struct RoomElementView: View {
    var room: Room
    let currentUserId: String
    @State var editing: Bool = false
    @State var toggleDelete: Bool = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            HStack{
                Text(room.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                if room.creatorId == currentUserId {
                    Button {
                        editing.toggle()
                    } label: {
                        Image(systemName: "pencil")
                    }.padding(.trailing, 8)
                }
                
            }.padding()
            
            //vou querer colocar aneis benzenos aqui no futuro, mas por enquanto já ta bom de MVP
            if editing {
                Button("Delete") {
                    toggleDelete.toggle()
                }.foregroundColor(.red)
                    .padding(.bottom, 12)
            }
        }
        .alert(isPresented: $toggleDelete) {
            Alert(
                title: Text("Delete Room"),
                message: Text("Are you sure you want to delete this room? This action is irreversible"),
                primaryButton: .destructive(
                    Text("Confirm"),
                    action: {
                        //$userManager.deleteRoom(roomToDelete: room)
                        editing.toggle()
                    }
                ),
                secondaryButton: .cancel()
            )
        }
    }
}

struct RoomElementView_Previews: PreviewProvider {
    static var previews: some View {
        RoomElementView(room: Room(id: "122", roomCode: "1323", name: "none", users: UserInRoom(userName: "alguem", userId: "123", score: 0, importedTasks: [])), currentUserId: "lo")
    }
}
