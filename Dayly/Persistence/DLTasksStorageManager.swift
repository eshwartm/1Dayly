//
//  DLTasksStorageManager.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 21/12/23.
//

import Foundation

class DLTasksStorageManager {
    
    static let shared = DLTasksStorageManager()
    private var tasks: [DLTask]?
    private var datewiseTaskStatus: [Date: [UUID: Bool]]?
    
    func initialize() {
        loadAllTasks()
        loadTaskAndDateInfo()
    }
    
    func loadTaskAndDateInfo() {
        datewiseTaskStatus = DLPersistenceManager.shared.fetchDatewiseInfo()
    }
    
    func loadAllTasks() {
        tasks = DLPersistenceManager.shared.fetchAllTasks()
    }
    
    func fetchTaskWith(id: UUID) -> DLTask? {
        guard tasksExist() else { return nil }
        return tasks?.filter { $0.id == id }.first
    }
    
    func getAllTasksFor(date: Date) -> [DLTask] {
        guard tasksExist(),
              let tasks = tasks
        else { return [] }
        
        return tasks.filter { task in
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
        
    func addTask(task: DLTask) throws {
        tasks?.append(task)
        try DLPersistenceManager.shared.addTask(task: task)
    }
    
    func deleteTask(task: DLTask) throws {
        let index = taskExists(task: task)
        if index == -1 {
            throw NSError(domain: "com.dayly.task.notFound", code: 602)
        }
        tasks?.remove(at: index)
        try DLPersistenceManager.shared.deleteTask(task: task)
    }
    
    func updateTask(task: DLTask) throws {
        let index = taskExists(task: task)
        if index == -1 {
            throw NSError(domain: "com.dayly.task.notFound", code: 600)
        }
        updateTaskWith(task: task, atIndex: index)
        try DLPersistenceManager.shared.updateTask(task: task)
    }
    
    private func updateTaskWith(task: DLTask, atIndex index: Int) {
        guard var taskToUpdate = tasks?[index] else { return }
        taskToUpdate.title = task.title
        taskToUpdate.brief = task.brief
        taskToUpdate.reminder = task.reminder
        taskToUpdate.startDate = task.startDate
        taskToUpdate.endDate = task.endDate
        taskToUpdate.streak = task.streak
        taskToUpdate.latestCompletionDate = task.latestCompletionDate
        taskToUpdate.streakCompleted = task.streakCompleted
        tasks?[index] = taskToUpdate
    }
    
    func completeTask(withId id: UUID, forDate date: Date) throws {
        datewiseTaskStatus?[date] = [id: true]
        try DLPersistenceManager.shared.completeTask(withId: id, forDate: date)
    }
    
    func completionStatus(forTask task: DLTask, forDate date: Date) -> Bool {
        if let allTasksStatusDict = datewiseTaskStatus?[date],
           let taskStatus = allTasksStatusDict[task.id]
        {
            return taskStatus
        }
        return false
    }
    
    private func tasksExist() -> Bool {
        return (tasks?.count ?? 0) > 0
    }
    
    private func taskExists(task: DLTask) -> Int {
        guard let index = (tasks?.firstIndex { task.id == $0.id }) else {
            return -1
        }
        return index
    }
}
