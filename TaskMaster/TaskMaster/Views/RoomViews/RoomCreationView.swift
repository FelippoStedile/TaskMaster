//
//  RoomCreationView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 19/09/23.
//

import SwiftUI

struct RoomCreationView: View {
    //da pra chamar em uma sheet
    
    @StateObject var viewModel: RoomCreationManager = RoomCreationManager()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button("Save") {
                
            }.disabled(viewModel.room.name.isEmpty)
            
            
            TextField("Room name", text: $viewModel.room.name)
            TextField("Password", text: $viewModel.room.password)
            
            
                Button {
                    viewModel.pointsPicker.toggle()
                } label: {
                    Text("Points per tasks completed:")
                    Text("\(viewModel.points)")
                        .foregroundColor(.accentColor)
                    
                }.buttonStyle(.plain)
            
            Button {
                viewModel.penalityPicker.toggle()
            } label: {
                Text("Points per tasks failed:")
                Text("\(viewModel.penalties)")
                    .foregroundColor(.accentColor)
                
            }.buttonStyle(.plain)
            
            Button {
                viewModel.hourPicker.toggle()
            } label: {
                Text("Max hour to disable tasks:")
                Text("\(viewModel.maxHour)")
                    .foregroundColor(.accentColor)
                
            }.buttonStyle(.plain)
                
            if viewModel.pointsPicker{
                Picker("Point per tasks completed", selection: $viewModel.points) {
                    ForEach(0..<11) { int in
                        Text("\(int)")
                    }
                }
                .pickerStyle(.wheel)
            } else if viewModel.penalityPicker {
                Picker("Point per tasks failed", selection: $viewModel.penalties) {
                    ForEach(0..<11) { int in
                        Text("\(int)")
                    }
                }
                .pickerStyle(.wheel)
            } else if viewModel.hourPicker {
                Picker("Point per tasks failed", selection: $viewModel.penalties) {
                        ForEach(0..<25) { int in
                            Text("\(int)")
                        }
                    }
                    .pickerStyle(.wheel)
            }
            
            
                
            
            
        }
    }
}

struct RoomCreationView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCreationView()
    }
}
