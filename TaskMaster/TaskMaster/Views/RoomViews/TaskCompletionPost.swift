//
//  TaskCompletionPost.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct TaskCompletionPost: View {
    
    @StateObject var viewModel: TaskCompletionModel = TaskCompletionModel()
    
    var body: some View {
        VStack(alignment: .leading){
            Text(viewModel.taskName)
            HStack{
                //Image(uiImage: viewModel.picture)
                Rectangle()
                    .frame(width: 200, height: 356)
                VStack{
                    
                    ForEach(0..<3){ int in
                        HStack(alignment: .top){
                            Text("User name")
                                .font(.footnote)
                                .fontWeight(.light)
                            Image(systemName: "checkmark.square")
                        }
                    }
                }
            }
            Divider()
        } .padding(.horizontal, 26)
    }
}

struct TaskCompletionPost_Previews: PreviewProvider {
    static var previews: some View {
        TaskCompletionPost()
    }
}
