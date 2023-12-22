//
//  DLSharedTasksRepository.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 21/12/23.
//

import Foundation

class DLSharedTasksRepository {
    
    static let shared = DLSharedTasksRepository()
    private var tasks: [DLTask] = []
    
    func fetchTasks() -> [DLTask] {
        return tasks
    }
    
    func addTask(task: DLTask) {
        tasks.append(task)
    }
    
    func deleteTask(task: DLTask) {
        tasks.removeAll { eachTask in
            eachTask.id == task.id
        }
    }
    
    func updateTask(task: DLTask) {
        guard var taskToUpdate = (tasks.first { task.id == $0.id }) else {
            return
        }
        taskToUpdate.title = task.title
        taskToUpdate.description = task.description
        taskToUpdate.reminder = task.reminder
        taskToUpdate.startDate = task.startDate
        taskToUpdate.endDate = task.endDate
        taskToUpdate.streak = task.streak
        taskToUpdate.latestCompletionDate = task.latestCompletionDate
        taskToUpdate.streakCompleted = task.streakCompleted
    }
}
