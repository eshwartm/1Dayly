//
//  DLTask.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import Foundation

protocol DLTaskProtocol {
    var id: UUID {get}
    var title: String {get}
    var description: String? {get}
    var reminder: Bool {get}
    var streak: Int {get}
    var startDate: Date {get}
    var endDate: Date? {get}
    var streakCompleted: Bool {get}
    
    mutating func markCompletedFor(date: Date)
}

struct DLTask: DLTaskProtocol, Identifiable {
    
    var id: UUID
    var title: String
    var description: String?
    var reminder: Bool
    var startDate: Date
    var endDate: Date?
    var streak: Int
    var latestCompletionDate: Date?
    var streakCompleted: Bool
        
    mutating func markCompletedFor(date: Date) {
        self.latestCompletionDate = date
    }
    
    func completedFor(date: Date) {
        if date.
    }
}

struct DLTasks {
    private var tasks: [DLTask]
}

extension Date {
    
    var tasks: [DLTask] {
        return DLSharedTasksRepository.shared.fetchTaskFor(date: self)
    }
    
    func completionStatusForTaskId(id: UUID) -> Bool {
        var tasksWithId = tasks.filter { $0.id == id }
        if var task = tasksWithId.first {
            task.
        }
            
        return false
    }
    
    func updateStatusForTaskWith(id: UUID) {
        var tasksWithId = tasks.filter { $0.id == id }
        if var task = tasksWithId.first {
            task.markCompletedFor(date: self)
        }
    }
    
    func markAllTasksCompleted() {
        for var eachTask in tasks {
            eachTask.markCompletedFor(date: self)
        }
    }
}

extension Calendar {
    
    func dateHasTasks(tasks: [DLTask], date: Date) -> Bool {
        for task in tasks {
            if self.isDate(date, inSameDayAs: task.startDate) {
                return true
            }
        }
        
        return false
    }
    
    func areTasksCompletedFor(tasks: [DLTask], date: Date) -> Bool {
        let completedArray = tasks.map {
            $0.streakCompleted == true
        }
        guard completedArray.count != tasks.count else {
            return true
        }
        return false
    }
    
    func numberOfTasksInDate(tasks: [DLTask], date: Date) -> Int {
        var count: Int = 0
        for task in tasks {
            if self.isDate(date, inSameDayAs: task.startDate) {
                count += 1
            }
        }
        return count
    }
}
