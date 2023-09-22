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
    
    @State var showSearchRoom: Bool = false
    @State var roomToSearch: String = ""
    @State var roomsSearched: [Room] = []
    @State var password: String = ""
    
    var body: some View {
            VStack{
                ScrollView{
                        ForEach(userManager.userRooms, id: \.id){ room  in
                            
                            RoomElementView(room: room, currentUserId: userManager.currentUser!.id)
                            
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(.accentColor)
                                )
                                .onTapGesture {
                                    viewModel.selectedRoom = room
                                    showRoom.toggle()
                                }
                    }.padding(.horizontal, 8)
                            .padding(.vertical, 4)
                    
                }
                Spacer()
                
                searchRoom()
                createRoomButton()
                
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
        }.sheet(isPresented: $showSearchRoom) {
            VStack(alignment: .center) {
                
                OtpFormFieldView() { search in
                    searchRooms(roomCode: search)
                }

                ForEach(roomsSearched, id: \.self) { room in
                    VStack{
                        HStack{
                            Text(room.name)
                                .font(.title)
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(room.memberID.count) members")
                        }
                        HStack {
                            TextField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                //.padding(4)
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Join")
                            }.padding(.trailing, 4)
                        }
                    }
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.accentColor)
                    )
                }.padding(.horizontal, 12)
            }
        }
    }
    
    
    func searchRooms(roomCode: String) {
        let predicade = NSPredicate(format: "roomCode == %@", roomCode)
        CloudKitService.shared.fetchFilteredData(predicate: predicade, type: Room.self) { result in
            switch result {
            case .success(let rooms):
                roomsSearched = rooms
            case .failure(let error):
                print("Error on \(#function): \(error.localizedDescription)")
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
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    private func searchRoom() -> some View {
        HStack {
                Button{
                    showSearchRoom.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("grayBackGround"))
                        Text("Search Room")
                            .font(.system(size: 25))
                            .foregroundColor(.accentColor)
                            .padding(.vertical, 8)
                    }
                }.buttonStyle(.plain)
                    .frame(height: 50)
        }.padding(.horizontal)
    }
    
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
