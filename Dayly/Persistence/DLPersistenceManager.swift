//
//  DLPersistenceManager.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 26/12/23.
//

import Foundation
import RealmSwift

class DLPersistenceManager {
    
    static let shared = DLPersistenceManager()
    private var db: Realm?
        
    func initializeDB() -> Bool {
        if let realm = try? Realm() {
            db = realm
            return true
        }
        return false
    }
    
    func fetchAllTasks() -> [DLTask]? {
        var originalTasks: [DLTask]?
        db?.objects(DLTaskObject.self).forEach({ taskObject in
            let task = DLTask(managedObject: taskObject)
            originalTasks?.append(task)
        })
        return originalTasks
    }
        
    func fetchDatewiseInfo() -> [Date: [UUID: Bool]]? {
        return (db?.objects(DLDatewiseTaskStatusObject.self).first as? DLDatewiseTaskStatusObject)?.statusString.dictionaryValue()
    }
        
    func completeTask(withId id: UUID, forDate date: Date) throws {
        
        var statusStringObject = DLDatewiseTaskStatusObject()
        
        var statusDict: [Date: [UUID: Bool]] = (db?.objects(DLDatewiseTaskStatusObject.self).first as? DLDatewiseTaskStatusObject)?.statusString.dictionaryValue() ?? [:]
        
        if statusDict.keys.count > 0 {
            statusDict[date] = [id: true]
        } else {
            statusDict[date] = [:]
        }
        
        let jsonStr = statusDict.jsonString()
        guard let jsonStr = statusDict.jsonString() else {
            throw NSError(domain: "com.dayly.db.statusObject", code: 605)
        }
        statusStringObject.statusString = jsonStr
        try db?.write({
            db?.add(statusStringObject, update: Realm.UpdatePolicy.all)
        })
    }
    
    func addTask(task: DLTask) throws {
        try db?.write({
            db?.add(task.managedObject())
        })
    }
    
    func deleteTask(task: DLTask) throws {
        guard let taskToDelete = db?.objects(DLTaskObject.self).filter({ $0.id == task.id }).first as? DLTask else {
            throw NSError(domain: "com.dayly.db.delete", code: 601)
        }
        try db?.write({
            db?.delete(taskToDelete.managedObject())
        })
    }
    
    func updateTask(task: DLTask) throws {
        guard let taskToUpdate = db?.objects(DLTaskObject.self).filter({ $0.id == task.id }).first as? DLTask else {
            throw NSError(domain: "com.dayly.db.delete", code: 601)
        }
        try db?.write({
            db?.add(taskToUpdate.managedObject(), update: .all)
        })
    }
}


