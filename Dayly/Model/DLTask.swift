//
//  DLTask.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import Foundation
import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

protocol DLTaskProtocol {
    var id: UUID {get}
    var title: String {get}
    var brief: String? {get}
    var reminder: Bool {get}
    var streak: Int {get}
    var startDate: Date {get}
    var endDate: Date? {get}
    var streakCompleted: Bool {get}
}

struct DLTask: DLTaskProtocol, Identifiable {
    
    var id: UUID
    var title: String
    var brief: String?
    var reminder: Bool
    var startDate: Date
    var endDate: Date?
    var streak: Int
    var latestCompletionDate: Date?
    var streakCompleted: Bool
}

struct DLDatewiseTaskStatus {
    
    static var info: [Date: [UUID: Bool]] = [:]
    
    init(date: Date, task: DLTask, completed: Bool) {
        DLDatewiseTaskStatus.info[date] = [task.id : completed]
    }
    
    static func fetchDatewiseTaskInfo() -> [Date: [UUID: Bool]] {
        return DLDatewiseTaskStatus.info
    }
}

final class DLDatewiseTaskStatusObject: Object {
    dynamic var statusString: String = ""
}

final class DLTaskObject: Object {
    dynamic var id: UUID = UUID()
    dynamic var title: String = ""
    dynamic var brief: String?
    dynamic var reminder: Bool = false
    dynamic var startDate: Date = Date()
    dynamic var endDate: Date?
    dynamic var streak: Int = 0
    dynamic var latestCompletionDate: Date?
    dynamic var streakCompleted: Bool = false
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension DLTask: Persistable {
    
    typealias ManagedObject = DLTaskObject
    
    init(managedObject: DLTaskObject) {
        id = managedObject.id
        title = managedObject.title
        brief = managedObject.brief
        reminder = managedObject.reminder
        startDate = managedObject.startDate
        endDate = managedObject.endDate
        streak = managedObject.streak
        latestCompletionDate = managedObject.latestCompletionDate
        streakCompleted = managedObject.streakCompleted
    }
    
    func managedObject() -> DLTaskObject {
        let taskObject = DLTaskObject()
        taskObject.id = id
        taskObject.brief = brief
        taskObject.reminder = reminder
        taskObject.startDate = startDate
        taskObject.endDate = endDate
        taskObject.streak = streak
        taskObject.latestCompletionDate = latestCompletionDate
        taskObject.streakCompleted = streakCompleted
        return taskObject
    }
}

extension Dictionary {
    
    func jsonString() -> String?
    {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8)
        }
        catch
        {
            return "Error converting JSON to string"
        }
    }
}

extension String {
    
    func dictionaryValue() -> [Date: [UUID: Bool]]?
    {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Date: [UUID: Bool]]
                return json
                
            } catch {
                print("Error converting String to JSON")
            }
        }
        return nil
    }
}

extension Date { // Date Helper
    
    var tasks: [DLTask] {
        return DLTasksStorageManager.shared.getAllTasksFor(date: self)
    }
    
    func completionStatus(forTask task: DLTask) -> Bool {
        return DLTasksStorageManager.shared.completionStatus(forTask: task, forDate: self)
    }
    
    func updateStatusForTaskWith(id: UUID) throws {
        var tasksWithId = tasks.filter { $0.id == id }
        if var task = tasksWithId.first {
            try DLTasksStorageManager.shared.completeTask(withId: task.id, forDate: self)
        }
    }
    
    func markAllTasksCompleted() throws {
        for eachTask in tasks {
            try DLTasksStorageManager.shared.completeTask(withId: eachTask.id, forDate: self)
        }
    }
}

extension Calendar { // Calendar Helper
    
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
