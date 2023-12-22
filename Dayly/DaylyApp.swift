//
//  DaylyApp.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

@main
struct DaylyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: DLTasksViewModel())   
        }
    }
}
