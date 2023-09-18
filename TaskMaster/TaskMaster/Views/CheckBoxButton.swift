//
//  CheckBoxButton.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 13/09/23.
//

import SwiftUI

struct CheckBoxCircle: View {
    @Binding var checked: Bool
    var body: some View {
        ZStack{
            Button(action: {
                if(self.checked){
                    self.checked = false
                }
                else{
                    self.checked = true
                }
            }, label: {
                HStack{
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 1)
                            .frame(width: 20, height: 20)
                        Circle()
                            .frame(width: 15, height: 15)
                            .foregroundColor(self.checked ? .blue : Color("antiprimary"))
                    }
                    Text("Due Date")
                }
            }).buttonStyle(.plain)
           
        }
    }
}

struct CheckBoxCircle_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxCircle(checked: .constant(true))
    }
}
