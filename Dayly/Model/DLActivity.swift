//
//  DLActivity.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import Foundation

protocol DLActivityProtocol {
    var id: UUID {get}
    var title: String {get}
    var description: String? {get}
    var reminder: Bool {get}
    var streak: Int {get}
    var startDate: Date? {get}
    var endDate: Date? {get}
    
    func markCompletedFor(date: Date)
}

struct DLActivities {
    var activities: [DLActivity]
}

struct DLActivity: DLActivityProtocol, Identifiable {
    
    var id: UUID
    var title: String
    var description: String?
    var reminder: Bool
    var startDate: Date?
    var endDate: Date?
    var streak: Int
    var completed: Bool
        
    func markCompletedFor(date: Date) {
        
    }
}
