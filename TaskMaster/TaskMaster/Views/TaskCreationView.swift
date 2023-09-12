//
//  TaskCreationView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

enum Period: String, CaseIterable, Identifiable {
    case monthly, weekly
    var id: Self { self }
}

struct TaskCreationView: View {
    var taskName: String
    var taskDueDate: Date
    //var weekDays: [Week]
    var monthDays: [Int]
    @State private var selectedPeriod: Period = .weekly
    @State var monday: Bool = false
    @State var tuesday: Bool = false
    @State var wednesday: Bool = false
    @State var thursday: Bool = false
    @State var friday: Bool = false




    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Image(systemName: "book.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                Text("Task Name")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            
            VStack {
                Picker("Period", selection: $selectedPeriod) {
                    Text("Weekly").tag(Period.weekly)
                    Text("Monthly").tag(Period.monthly)
                }.pickerStyle(.segmented)
            
                if selectedPeriod == .weekly {
                    HStack {
                        ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self){ day in
                            Button {
                                monday.toggle()
                            } label: {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 20)
                                    Text(day.dropLast(2))
                                }
                                .foregroundColor(monday ? .blue : .primary)
                            }.buttonStyle(.plain)
                        }
                        Button {
                            tuesday.toggle()
                        } label: {
                            ZStack{
                                Circle().stroke()
                                    .frame(height: 20)
                                Text("M")
                            }
                            .foregroundColor(tuesday ? .blue : .primary)
                        }.buttonStyle(.plain)
                        ZStack{
                            Circle().stroke()
                                .frame(height: 20)
                            Text("T")
                        }
                        ZStack{
                            Circle().stroke()
                                .frame(height: 20)
                            Text("W")
                        }
                        ZStack{
                            Circle().stroke()
                                .frame(height: 20)
                            Text("T")
                        }
                        ZStack{
                            Circle().stroke()
                                .frame(height: 20)
                            Text("F")
                        }
                        ZStack{
                            Circle().stroke()
                                .frame(height: 20)
                            Text("S")
                        }
                    }
                }
                HStack{
                    ProgressView(value:0.1)
                    Text("10/09")
                }
            }
        }
    }
}

struct TaskCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationView(taskName: "Oi", taskDueDate: Date(), monthDays: [10, 20])
    }
}
