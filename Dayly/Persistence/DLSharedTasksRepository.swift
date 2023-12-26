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
    private var taskWithDateInfo: [Date: [UUID: Bool]] = [:]
    
    func loadTaskAndDateInfo() -> [Date: [UUID: Bool]] {
        taskWithDateInfo = [:] // DLPersistenceManager.fetchTaskAndDates()
        return taskWithDateInfo
    }
    
    func fetchAll() -> [DLTask] {
        return tasks
    }
    
    func fetchTaskFor(id: UUID) -> DLTask? {
        tasks.filter { $0.id == id }.first
    }
    
    func fetchTaskFor(date: Date) -> [DLTask] {
        tasks.filter { task in
            if task.startDate <= Date()
            {
                if let endDate = task.endDate
                {
                    if endDate <= Date() {
                        return true
                    }
                }
                else {
                    return true
                }
            }
            return false
        }
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
    
    func completeTask(withId id: UUID, forDate date: Date) {
        if var taskInfo = taskWithDateInfo[date]
        {
            taskInfo[id] = true
        }
    }
}
