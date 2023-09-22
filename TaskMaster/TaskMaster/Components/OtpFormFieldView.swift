//
//  OtpFormFieldView.swift
//  TaskMaster
//
//  Created by Filipe Ilunga on 22/09/23.
//

import SwiftUI
import Combine
import SwiftUI
import Combine

struct OtpFormFieldView: View {
    //MARK -> PROPERTIES

    enum FocusPin {
        case  pinOne, pinTwo, pinThree, pinFour, pinFive
    }

    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""

    var search: (String) -> ()

    //MARK -> BODY
    var body: some View {
            VStack {

                Text("Find a room for you to be part of.")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text("Enter a 5-digit code to search for a room.")
                    .font(.caption)
                    .fontWeight(.thin)
                    .padding(.top)

                HStack(spacing:15, content: {

                    TextField("", text: $pinOne)
                        .modifier(OtpModifer(pin:$pinOne))
                        .onChange(of:pinOne){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinTwo
                            }
                        }
                        .focused($pinFocusState, equals: .pinOne)

                    TextField("", text:  $pinTwo)
                        .modifier(OtpModifer(pin:$pinTwo))
                        .onChange(of:pinTwo){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinThree
                            }else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinOne
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinTwo)


                    TextField("", text:$pinThree)
                        .modifier(OtpModifer(pin:$pinThree))
                        .onChange(of:pinThree){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFour
                            }else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinTwo
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinThree)


                    TextField("", text:$pinFour)
                        .modifier(OtpModifer(pin:$pinFour))
                        .onChange(of:pinFour){newVal in
                            if (newVal.count == 1) {
                                pinFocusState = .pinFive
                            } else {
                                if (newVal.count == 0) {
                                    pinFocusState = .pinThree
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinFour)
                    
                    TextField("", text:$pinFive)
                        .modifier(OtpModifer(pin:$pinFive))
                        .onChange(of:pinFive){newVal in
                            if (newVal.count == 0) {
                                withAnimation {
                                    pinFocusState = .pinFour
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinFive)


                })
                .padding(.vertical)


                Button {
                    let textToSearch: String = pinOne + pinTwo + pinThree + pinFour + pinFive
                    search(textToSearch)
                    
                } label: {
                    Spacer()
                    Text("Search")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(uiColor: UIColor.label))
                    Spacer()
                }
                .padding(15)
                .background(Color.accentColor)
                .clipShape(Capsule())
                .padding()
            }

    }
}
