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
    @State var taskName: String
    @State var monthDays: [Int]
    @State var selectedPeriod: Period
    @State var selectedWeek: [Week]
    @State var dueDate: Date
    
    @State var dueBool: Bool
    @State private var showCalendar: Bool = false
    
    @Binding var editing: Bool
    
    let weekDays: [Week] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]




    
    var body: some View {
        VStack(alignment: .leading){
            if editing{
                HStack{
                    Spacer()
                    Button("Save") {
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Cancel") {
                        
                        editing.toggle()
                    }
                    Spacer()
                    Button("Delete") {
                        
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
                    ZStack{
                        //Rectangle()
                        TextField("Task Name:", text: $taskName, axis: .vertical)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .limitInputLength(value: $taskName, length: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                            )
                    }
                } else {
                    Text("\(taskName)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
            }
            
            VStack(alignment: .leading) {
                
                if editing {
                    Picker("Period", selection: $selectedPeriod) {
                        Text("Weekly").tag(Period.weekly)
                        Text("Monthly").tag(Period.monthly)
                    }.pickerStyle(.segmented)
                        .padding(.bottom, 4)
                }
                
                if selectedPeriod == .weekly {
                    HStack {
                        ForEach(weekDays, id: \.self){ day in
                            if editing {
                                Button {
                                    selectedWeek.contains(day) ? selectedWeek = selectedWeek.filter {$0 != day} : selectedWeek.append(day)
                                } label: {
                                    ZStack{
                                        Circle().stroke()
                                            .frame(height: 25)
                                        Text(day.dayLetter)
                                    }
                                    .foregroundColor(selectedWeek.contains(day) ? .blue : .primary)
                                }.buttonStyle(.plain)
                            } else {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 25)
                                    Text(day.dayLetter)
                                }
                                .foregroundColor(selectedWeek.contains(day) ? .blue : .primary)
                            }
                        }
                    }
                } else {
                    HStack {
                        ForEach(monthDays, id: \.self){ day in
                            if editing {
                                Button {
                                    monthDays = monthDays.filter{$0 != day}
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
                                showCalendar = true
                            } label: {
                                Image(systemName: "plus")
                            }.padding(.vertical, 4)
                        }
                    }
                    
                }
                if editing {
                    HStack{
                        CheckBoxCircle(checked: $dueBool)
                        if (dueBool) {
                            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                            //.padding(.trailing, 150)
                        } else {
                            Text("Due Date")
                        }
                    }
                } else {
                    if dueBool {
                        HStack{
                            ProgressView(value:0.0)
                            Text("\(dueDate.formatted(.dateTime.day().month().year()))")
                        }
                    }
                }
            }
        }.padding(8)
        
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color(red: 0.95, green: 0.95, blue: 0.95))
        )
        
        
        .sheet(isPresented: $showCalendar) {
            monthDays.sort()
        } content: {
                VStack{
                    ForEach(0..<4) { line in
                        HStack{
                            ForEach(1..<8){item in
                                let day = item + line * 7
                                Button{
                                    monthDays.contains(day) ? monthDays = monthDays.filter {$0 != day} : monthDays.count < 10 ?  monthDays.append(day) : nil
                                } label:
                                {
                                    ZStack{
                                        Circle().stroke()
                                            .frame(height: 40)
                                        Text("\(day)")
                                    }
                                    .foregroundColor(monthDays.contains(day) ? .blue : .primary)
                                }.buttonStyle(.plain)
                        }
                    }
                }
                    HStack{
                        ForEach(29..<32) {rest in
                            Button{
                                monthDays.contains(rest) ? monthDays = monthDays.filter {$0 != rest} : monthDays.count < 10 ? monthDays.append(rest) : nil
                            } label:
                            {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 40)
                                    Text("\(rest)")
                                }
                                .foregroundColor(monthDays.contains(rest) ? .blue : .primary)
                            }.buttonStyle(.plain)
                        }
                    }
            }
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(taskName: "", monthDays: [], selectedPeriod: .weekly, selectedWeek: [], dueDate: Date(), dueBool: true, editing: .constant(true))
    }
}

#warning("Fazer o due bool n ser enviado, ser um resultado da presença de um dueDate que deveria ser optional")
