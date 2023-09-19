//
//  RoomView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomView: View {
    
    @StateObject var viewModel: RoomManager = RoomManager()

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal){
                LazyHStack{
                    ForEach(0..<3) { int in
                        UserListElementView()
                    }
                }
            }
            .frame(height: 60)
            Divider()
            
            ScrollView{
                
                Button("Upload Task Completion Proof") {
                    viewModel.takingPic.toggle()
                }.padding(.top)
                
                Spacer().frame(height: 200)
            
                ForEach(0..<5){ int in
                    TaskCompletionPost()
                }
            }
        }
        .sheet(isPresented: $viewModel.takingPic) {
            Camera(selectedImage: $viewModel.newPhoto, sourceType: .camera)
        }
    }
}

struct RoomView_Previews: PreviewProvider {
    static var previews: some View {
        RoomView()
    }
}
