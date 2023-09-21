//
//  UserListElementView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct UserListElementView: View {
    
    var userName: String
    var userScore: Int
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(userName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Image(systemName: "chevron.down")
                Spacer()
            }
            Text("\(userScore)")
                
                
            
        }.padding(.horizontal, 8)
    }
}

struct UserListElementView_Previews: PreviewProvider {
    static var previews: some View {
        UserListElementView(userName: "pablo", userScore: 12)
    }
}
