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

struct TaskCreationView: View {
    var taskName: String
    var taskDueDate: Date
    //var weekDays: [Week]
    @State var monthDays: [Int]
    @State private var selectedPeriod: Period = .weekly
    @State var selectedWeek: [Week]
    @State private var date = Date()
    @State private var showCalendar: Bool = false
    
    let weekDays: [Week] = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]




    
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
            
            VStack(alignment: .leading) {
                Picker("Period", selection: $selectedPeriod) {
                    Text("Weekly").tag(Period.weekly)
                    Text("Monthly").tag(Period.monthly)
                }.pickerStyle(.segmented)
            
                if selectedPeriod == .weekly {
                    HStack {
                        ForEach(weekDays, id: \.self){ day in
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
                        }
                    }
                } else {
                    HStack {
                        ForEach(monthDays, id: \.self){ day in
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
                        Button {
                            showCalendar = true
                        } label: {
                            Image(systemName: "plus")
                        }

                    }
                    
                }
                HStack{
                    ProgressView(value:0.1)
                    Text("10/09")
                }
            }
        }
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
                    #warning("Fazer a view de edit ter a sheet por padrao, e a view do elemento normal ser só as bolinhas")
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

struct TaskCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationView(taskName: "Oi", taskDueDate: Date(), monthDays: [10, 20], selectedWeek: [])
    }
}
