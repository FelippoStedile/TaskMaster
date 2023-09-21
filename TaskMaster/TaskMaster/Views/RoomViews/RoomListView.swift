//
//  RoomListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

final class RoomListViewModel: ObservableObject {
    @Published var selectedRoom: Room?

}

struct RoomListView: View {
    
    @StateObject var viewModel: RoomListViewModel = RoomListViewModel()
    
    @State var isCreating: Bool = false
    @State var showRoom: Bool = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading){
                ScrollView{
                        ForEach(userManager.userRooms, id: \.id){ room  in
                            
                            RoomElementView(room: room, currentUserId: userManager.currentUser!.id)
                            
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(lineWidth: 1)
                                    .foregroundColor(.blue)
                            )
                            .onTapGesture {
                                viewModel.selectedRoom = room
                                showRoom.toggle()
                            }
                        
                    }.padding(.horizontal, 8)
                        .padding(.vertical, 4)
                }
                Spacer()
                
                createRoomButton()
                
            }
        }
        .sheet(isPresented: $isCreating) {
            RoomCreationView(showRoomCreation: $isCreating)
                .environmentObject(userManager)
        }.fullScreenCover(isPresented: $showRoom) {
            if let room = viewModel.selectedRoom {
                RoomView(room: .constant(room), showRoom: $showRoom)
            } else {
                Text("Nada")
            }
        }
    }
    
    @ViewBuilder
    private func createRoomButton() -> some View {
        HStack {
            if !userManager.creating{
                Button{
                    isCreating.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("grayBackGround"))
                        Text("Create Room")
                            .font(.system(size: 25))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 8)
                    }
                }.buttonStyle(.plain)
                    .frame(height: 50)
            }
        }
    }
    
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
