//
//  ContentView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @ObservedObject var viewModel: DLActivitiesViewModel
    @State private var isPresentingAddTaskView = false
    @State private var dayStreak: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarView(calendar: Calendar(identifier: .gregorian))
            }
            .padding()
            .navigationTitle("This Month")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Perform an action
                        print("Add Item")
                        isPresentingAddTaskView = true
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddTaskView) {
                AddDailyActivityView(title: "", date: Date(), reminder: true)
            }
        }
        .onAppear(perform: {
            registerForLocalNotificationsPermission()
        })
    }
    
    func registerForLocalNotificationsPermission() {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
                scheduleLocalNotification()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    ContentView(viewModel: DLActivitiesViewModel())
}
