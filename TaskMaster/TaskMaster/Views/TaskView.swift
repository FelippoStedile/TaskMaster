//
//  TaskCreationView.swift
//  TaskMaster
//
//  Created by Felippo Stedile on 12/09/23.
//

import SwiftUI

struct TaskView: View {
    @Binding var task: TaskModel
    @StateObject var viewModel: TaskManager = TaskManager(dueBool: false)
    
    @EnvironmentObject var userManager: UserManager
    
    @State var editing: Bool = false

    var body: some View {
        VStack(alignment: .leading){
            if editing{
                HStack{
                    Spacer()
                    Button("Save") {
                        
                        if task.taskName.isEmpty { //quer dizer que recebeu a taskToCreate, está criando
                             viewModel.createTask() { result in
                                 if let result =  result {
                                     DispatchQueue.main.async {
                                         task = result
                                     }
                                 }
                            }
                            
                        } else {
                            if let record = task.record {
                                
                                let result = viewModel.update(record: record)
                                task = result
                                
                            } else {
                                print("Record nil")
                            }
                        }
                        
                        editing.toggle()
                    } .disabled(viewModel.task.taskName.isEmpty)
                    if !viewModel.disableDelete {
                        Spacer()
                        Button("Cancel") {
                            viewModel.task.taskName = task.taskName
                            //viewModel.task.icon = task.icon
                            viewModel.task.dueDate = task.dueDate
                            viewModel.task.monthDays = task.monthDays
                            viewModel.task.weekDays = task.weekDays
                            viewModel.task.selectedPeriod = task.selectedPeriod
                            
                            viewModel.cancel()
                            editing.toggle()
                        }
                        Spacer()
                        
                        Button("Delete") {
                            viewModel.toggleDelete()
                        }.foregroundColor(.red)
                        
                        
                        Spacer()
                    }
                }
            }
            HStack {
                /*if editing{
                    Button{
                        viewModel.task.icon = UIImage(systemName: "book.circle")!
                    } label: {
                        Image(systemName: "paintbrush")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }
                } else {*/
                    Image(/*uiImage: viewModel.task.icon*/ systemName: "book.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                //}
                
                if editing {
                    TextField("Task Name:", text: $viewModel.task.taskName, axis: .vertical)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .limitInputLength(value: $viewModel.task.taskName, length: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .foregroundColor(Color("grayBackGround"))
                            )
                } else {
                    Text("\(viewModel.task.taskName)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
                Spacer()
                if !editing {
                    Button {
                        editing.toggle()
                    } label: {
                        Image(systemName: "pencil")
                    }.padding(.trailing, 8)
                }
            }
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                
                if editing {
                    Picker("Period", selection: $viewModel.task.selectedPeriod) {
                        Text("Weekly").tag(Period.weekly)
                        Text("Monthly").tag(Period.monthly)
                    }.pickerStyle(.segmented)
                        .padding(.bottom, 4)
                }
                
                    if viewModel.task.selectedPeriod == .weekly {
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
                                if task.weekDays != [-1] {
                                ZStack{
                                    Circle().stroke()
                                        .frame(height: 25)
                                    Text(day.dayLetter)
                                }
                                .foregroundColor(viewModel.containsWeekDay(day: day))
                            }
                            }
                        }
                        Spacer()
                    } .padding(.bottom, 7)
                        .padding(.leading, 6)
                } else {
                    HStack {
                        if viewModel.task.monthDays != [-1] {
                            ForEach(viewModel.task.monthDays, id: \.self){ day in
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
            }
                if editing {
                    HStack{
                        CheckBoxCircle(checked: $viewModel.dueBool)
                            .padding(.vertical, 7)
                        Spacer()
                        if (viewModel.dueBool) {
                            DatePicker("Due Date", selection: $viewModel.task.dueDate, in: Date()..., displayedComponents: .date)
                                .labelsHidden()
                        }
                    }
                } else {
                    if viewModel.task.dueDate > Date.distantPast {
                        if let progress = viewModel.progressValue() {
                            HStack{
                                ProgressView(value: progress)
                                Text("\(viewModel.task.dueDate.formatted(.dateTime.day().month().year()))")
                            }
                        }
                    }
                }
            } 
        }.padding(8)
        
        .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(Color("antiPrimary"))
        )
        
        
        .sheet(isPresented: $viewModel.showCalendar){
                VStack{
                    ForEach(0..<4) { line in
                        HStack{
                            ForEach(1..<8){item in
                                let day = item + line * 7
                                #warning("Seria bom botar isso ^ na VM?")
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
                        userManager.deleteTask(taskToDelete: task)
                        /*n deu pra colocar a chamado do servico na VM dessa view, aí coloquei na vm da lista pra n ficar aqui no meio da view. N deu pq a vm dessa view n tem a task em si, só a versao que vai sobrescrever*/
                        editing.toggle()
                    }
                ),
                secondaryButton: .cancel()
            )
        }
        .onAppear(){
            viewModel.disableDelete = editing
            viewModel.task.taskName = task.taskName
            viewModel.task.dueDate = task.dueDate
            if viewModel.task.dueDate > Date.distantPast {
                viewModel.dueBool = true
            }
            //viewModel.task.icon = task.icon
            viewModel.task.monthDays = task.monthDays
            viewModel.task.weekDays = task.weekDays
            viewModel.task.selectedPeriod = task.selectedPeriod
        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView(task: .constant(TaskModel(id: UUID().uuidString, taskName: "Cappihilation", selectedPeriod: .weekly, monthDays: [-1], weekDays: [1, 2], dueDate: Date())))
//    }
//}
