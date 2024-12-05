//
//  Task.swift
//  ToDoList
//
//  Created by Merianni Nunez Tejeda on 12/5/24.
//
import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
