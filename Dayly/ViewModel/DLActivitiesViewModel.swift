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
            DLActivity(title: "Yoga", description: "Practice Yoga Kriya", dateTime: nil, reminder: true),
            DLActivity(title: "Carnatic", description: "Practice Jantai Varisai", dateTime: nil, reminder: false)
        ]
    }
    
}
