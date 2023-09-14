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

enum Week: Int {
    case sunday = 0
    case monday = 1
    case tuesday = 2
    case wednesday = 3
    case thursday = 4
    case friday = 5
    case saturday = 6
    
    var dayLetter: String {
        switch self{
        case .sunday: return "S"
        case .monday: return "M"
        case .tuesday: return "T"
        case .wednesday: return "W"
        case .thursday: return "T"
        case .friday: return "F"
        case .saturday: return "S"
        }
    }
    
}

struct TaskView: View {
    @Binding var task: TaskModel
    @StateObject var viewModel: TaskManager = TaskManager(dueBool: false)
    @Binding var editing: Bool

    var body: some View {
        VStack(alignment: .leading){
            if editing{
                HStack{
                    Spacer()
                    Button("Save") {
                        let result = viewModel.upload()
                        
                        task.taskName = result.name
                        task.selectedPeriod = result.period
                        task.weekDays = result.weekDays
                        task.dueDate = result.dueDate
                        task.monthDays = result.monthDays
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Cancel") {
                        viewModel.cancel()
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Delete") {
                        viewModel.toggleDelete()
                    }.foregroundColor(.red)
                    Spacer()
                    
                }//.padding(.vertical, 8)
            }
            
            HStack {
                Image(systemName: "book.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                
                if editing {
                    TextField("Task Name:", text: $viewModel.taskName, axis: .vertical)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .limitInputLength(value: $viewModel.taskName, length: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                            )
                } else {
                    Text("\(viewModel.taskName)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                
                if editing {
                    Picker("Period", selection: $viewModel.selectedPeriod) {
                        Text("Weekly").tag(Period.weekly)
                        Text("Monthly").tag(Period.monthly)
                    }.pickerStyle(.segmented)
                        .padding(.bottom, 4)
                }
                
                if viewModel.selectedPeriod == .weekly {
                    HStack {
                        ForEach(viewModel.weekDays, id: \.self){ day in
                            if editing {
                                Button {
                                    viewModel.selectWeek(day: day)
                                } label: {
                                    ZStack{
                                        Circle().stroke()
                                            .frame(height: 25)
                                        Text(day.dayLetter)
                                    }
                                    .foregroundColor(viewModel.containsWeekDay(day: day))
                                }.buttonStyle(.plain)
                            } else {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 25)
                                    Text(day.dayLetter)
                                }
                                .foregroundColor(viewModel.containsWeekDay(day: day))
                            }
                        }
                        Spacer()
                    } .padding(.bottom, 7)
                        .padding(.leading, 6)
                } else {
                    HStack {
                        if let monthDays = viewModel.monthDays {
                            ForEach(monthDays, id: \.self){ day in
                                if editing {
                                    Button {
                                        viewModel.selectMonth(day: day)
                                    } label: {
                                        ZStack{
                                            Circle().stroke()
                                                .frame(height: 25)
                                            Text("\(day)")
                                        }
                                    }.buttonStyle(.plain)
                                }
                                else {
                                    ZStack{
                                        Circle().stroke()
                                            .frame(height: 25)
                                        Text("\(day)")
                                    }
                                }
                            }
                        }
                        if editing {
                            Button {
                                viewModel.showCalendar = true
                            } label: {
                                Image(systemName: "plus")
                            }.padding(.vertical, 4)
                        }
                        Spacer()
                    }.padding(.bottom, 7)
                        .padding(.leading, 6)
                }
            } .background(
                //editing ?
//                RoundedRectangle(cornerRadius: 8, style: .continuous)
//                        .stroke(lineWidth: 2)
//                    .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                //: EmptyView()
            )
                if editing {
                    HStack{
                        CheckBoxCircle(checked: $viewModel.dueBool)
                            .padding(.vertical, 7)
                        if (viewModel.dueBool) {
                            #warning("se eu vou fazer o unwrap aqui ele n da pra passar pro DatePicker se ser binding")
                            DatePicker("Due Date", selection: $viewModel.dueDate2, in: Date()..., displayedComponents: .date)
                        } else {
                            Text("Due Date")
                        }
                    }
                } else {
                    if let dueDate = viewModel.dueDate {
                        HStack{
                            ProgressView(value:0.0)
                            Text("\(dueDate.formatted(.dateTime.day().month().year()))")
                        }
                    }
                }
            } 
        }.padding(8)
        
        .background(
            //ZStack{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color(red: 1, green: 1, blue: 1))
//                RoundedRectangle(cornerRadius: 20, style: .continuous)
//                    .stroke(lineWidth: 1)
//                    .foregroundColor(Color(red: 0, green: 0, blue: 1))
            //}
        )
        
        
        .sheet(isPresented: $viewModel.showCalendar){
                VStack{
                    ForEach(0..<4) { line in
                        HStack{
                            ForEach(1..<8){item in
                                let day = item + line * 7
                                #warning("Tem como botar isso ^ na VM?")
                                Button{
                                    viewModel.selectMonth(day: day)
                                } label: {
                                    ZStack{
                                        Circle().stroke()
                                            .frame(height: 40)
                                        Text("\(day)")
                                    }
                                    .foregroundColor(viewModel.containsMonthDay(day: day))
                                }.buttonStyle(.plain)
                        }
                    }
                }
                    HStack{
                        ForEach(29..<32) {rest in
                            Button{
                                viewModel.selectMonth(day: rest)
                            } label:
                            {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 40)
                                    Text("\(rest)")
                                }
                                .foregroundColor(viewModel.containsMonthDay(day: rest))
                            }.buttonStyle(.plain)
                        }
                    }
            }
        }
        .alert(isPresented: $viewModel.deleteAlert) {
            Alert(
                title: Text("Delete Task"),
                message: Text("Are you sure you want to delete this task? This action is irreversible"),
                primaryButton: .destructive(
                    Text("Confirm"),
                    action: {
                        viewModel.cancel()
                        editing.toggle()
                    }
                ),
                secondaryButton: .cancel()
            )
        }
        .onAppear(){
            viewModel.taskName = task.taskName
            viewModel.dueDate = task.dueDate
            viewModel.monthDays = task.monthDays
            viewModel.selectedWeek = task.weekDays
            viewModel.selectedPeriod = task.selectedPeriod
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .constant(TaskModel(id: "Cappihilation", taskName: "Cappihilation", selectedPeriod: .weekly, monthDays: nil, weekDays: [.monday, .wednesday], dueDate: nil)), editing: .constant(true))
    }
}
