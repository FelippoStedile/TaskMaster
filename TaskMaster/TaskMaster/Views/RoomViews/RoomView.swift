//
//  RoomView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomView: View {
    
    @StateObject var viewModel: RoomViewModel = RoomViewModel()

    @Binding var room: Room
    @Binding var showRoom: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
           
            VStack(alignment: .leading) {
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(0..<3) { users in
                            UserListElementView()
                        }
                    }
                }
                .frame(height: 60)
                Divider()
                
                ScrollView{
                    
                    Button("Upload Task Completion Proof") {
                            viewModel.pickingTaskToComplete.toggle()
                    }.padding(.top)
                    
                    Spacer().frame(height: 200)
                
                    ForEach(viewModel.feed, id: \.self){ taskCompleted in
                        TaskCompletionPost()
                    }
                }
            }
            
            Button {
                showRoom.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
                        
        }
        

//        .sheet(isPresented: $viewModel.pickingTaskToComplete) {
//        ForEach(0..<3){ userTask in
//            Button{
//                viewModel.takingPic.toggle()
//                //viewModel.selectedTask = userTask
//            } label: {
//                //Text(userTask.name)
//            }
//
//        }
//
//        .sheet(isPresented: $viewModel.takingPic) {
//            Camera(selectedImage: $viewModel.newPhoto, sourceType: .camera)
//
//                .onDisappear{
//                    viewModel.feed.insert(TaskCompletionModel(picture: viewModel.newPhoto, taskName: viewModel.selectedTask.taskName, approvals: []), at: 0)
//                }
//        }
//    }
    }
}

//struct RoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoomView()
//    }
//}
