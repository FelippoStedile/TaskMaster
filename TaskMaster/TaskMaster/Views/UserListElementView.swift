//
//  UserListElementView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct UserListElementView: View {
    @State var toggleTasks: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("User Name")
                    .font(.title)
                    .fontWeight(.semibold)
                Button {
                    toggleTasks.toggle()
                } label: {
                    Image(systemName: "chevron.down")
                }
                Spacer()
            }
        }.padding(.horizontal, 8)
            .sheet(isPresented: $toggleTasks) {
                VStack{
                    HStack{
                        Text("Task name")
                            .fontWeight(.thin)
                            .font(.headline)
                        Image(systemName: "square")
                        Spacer()//
                    }.padding(.leading, 12)
                    
                    Spacer()
                    
                    HStack {
                        Button{

                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(Color("grayBackGround"))
                                Text("Import Tasks")
                                    .font(.system(size: 25))
                                    .foregroundColor(.accentColor)
                                    .padding(.vertical, 8)
                            }
                        }.buttonStyle(.plain)
                    }
                }
            }
    }
}

struct UserListElementView_Previews: PreviewProvider {
    static var previews: some View {
        UserListElementView(toggleTasks: false)
    }
}
