//
//  DLActivitiesViewModel.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import Foundation

class DLActivitiesViewModel: ObservableObject {
    
    @Published var activities = [DLActivity]()
    
    init(activities: [DLActivity] = [DLActivity]()) {
        self.activities = activities
    }
    
    func load() {
        self.activities = [
            DLActivity(id: UUID(), title: "Yoga", reminder: true, streak: 2, completed: false),
            DLActivity(id: UUID(), title: "Carnatic Music", reminder: true, streak: 4, completed: false)
        ]
    }
    
}
