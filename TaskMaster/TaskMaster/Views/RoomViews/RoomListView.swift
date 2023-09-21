//
//  RoomListView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomListView: View {
    @State var isCreating: Bool = false
    
    var body: some View {
        VStack {
        ZStack{
            ScrollView{
                VStack{
                    ForEach(0..<4){ int in
                        
                        HStack{
                            NavigationLink{
                                RoomView()
                            } label: {
                                Text("room 1")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                            Spacer()
                            //if room.creator == self {
                            NavigationLink{
                                
                            } label: {
                                Image(systemName: "pencil")
                            }
                            //}
                            
                        } .padding(.horizontal, 26)
                    }
                }
            }
            
            VStack{
                Spacer().frame(height: 700)
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
            }.padding(.horizontal, 12)
        }
    }
        .sheet(isPresented: $isCreating) {
            RoomCreationView()
        }
    }
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView()
    }
}
