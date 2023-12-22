//
//  DLTasksViewModel.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import Foundation

class DLTasksViewModel: ObservableObject {
    
    @Published var tasks = [DLTask]()
    
    init(tasks: [DLTask] = [DLTask]()) {
        self.tasks = tasks
    }
    
    func load() {
        self.tasks = [
            DLTask(id: UUID(), title: "Yoga", reminder: true, streak: 2, streakCompleted: false),
            DLTask(id: UUID(), title: "Carnatic Music", reminder: true, streak: 4, streakCompleted: false)
        ]
    }
    
}
