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
    @StateObject var viewModel: TaskManager = TaskManager(dueBool: false)
    @Binding var editing: Bool

    var body: some View {
        VStack(alignment: .leading){
            if editing{
                HStack{
                    Spacer()
                    Button("Save") {
                        viewModel.upload()
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Cancel") {
                        viewModel.cancel()
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Delete") {
                        viewModel.delete()
                        
                        editing.toggle()
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
                    }
                } else {
                    HStack {
                        ForEach(viewModel.monthDays, id: \.self){ day in
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
                        if editing {
                            Button {
                                viewModel.showCalendar = true
                            } label: {
                                Image(systemName: "plus")
                            }.padding(.vertical, 4)
                        }
                        Spacer()
                    }
                    
                }
                if editing {
                    HStack{
                        CheckBoxCircle(checked: $viewModel.dueBool)
                        if (viewModel.dueBool) {
                            DatePicker("Due Date", selection: $viewModel.dueDate2, displayedComponents: .date)
                            //.padding(.trailing, 150)
                        } else {
                            Text("Due Date")
                        }
                    }
                } else {
                    if viewModel.dueBool {
                        HStack{
                            ProgressView(value:0.0)
                            Text("\(viewModel.dueDate2.formatted(.dateTime.day().month().year()))")
                        }
                    }
                }
            }
        }.padding(8)
        
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
        )
        
        
        .sheet(isPresented: $viewModel.showCalendar) {
            viewModel.monthDays.sort()
        } content: {
                VStack{
                    ForEach(0..<4) { line in
                        HStack{
                            ForEach(1..<8){item in
                                let day = item + line * 7
                                Button{
                                    viewModel.selectMonth(day: day)
                                } label:
                                {
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
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(editing: .constant(true))
    }
}

#warning("Fazer o due bool n ser enviado, ser um resultado da presença de um dueDate que deveria ser optional")
