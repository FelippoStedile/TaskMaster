//
//  RoomCodeView.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 22/09/23.
//

import SwiftUI
import Combine

struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }


    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
           // .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 45, height: 45)
            .autocorrectionDisabled()
            .background(Color.gray.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    //.stroke(.blue, lineWidth: 2)
            )
    }
    
    
}
