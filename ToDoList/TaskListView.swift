//
//  ContentView.swift
//  ToDoList
//
//  Created by Merianni Nunez Tejeda on 12/5/24.
//

import Foundation
import SwiftUI

struct TaskRowView: View {
    var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .yellow : .yellow)
            Text(task.title)
                .strikethrough(task.isCompleted, color: .yellow)
                .foregroundColor(task.isCompleted ? .gray : .black)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel()
    @State private var isShowingAddTaskView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) {
                    task in TaskRowView(task: task)
                        .onTapGesture {
                            viewModel.toggleTask(task: task)
                        }
                }
                .onDelete(perform: viewModel.deleteTask)
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem() {
                    EditButton()
                        .foregroundColor(.yellow)
                }
                ToolbarItem() {
                    Button(action: {
                        isShowingAddTaskView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.yellow)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTaskView) {
                AddTaskView(viewModel: viewModel, isPresented: $isShowingAddTaskView)
            }
        }
    }
}

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var isPresented: Bool
    @State var taskTitle: String = ""
    @State var showValidationError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Task Title", text: $taskTitle)
                    .padding()
                
                if showValidationError {
                    Text("Task title is required")
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Add New Task")
            .toolbar {
                ToolbarItem() {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem() {
                    Button("Save") {
                        saveTask()
                    }
                }
            }
        }
    }
    
    func saveTask() {
        if taskTitle.isEmpty {
            showValidationError = true
            return
        }
        
        viewModel.addTask(title: taskTitle)
        isPresented = false
    }
}

#Preview {
    TaskListView()
}

