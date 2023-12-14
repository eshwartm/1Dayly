//
//  ContentView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: DLActivitiesViewModel
    @State private var isPresentingAddTaskView = false
    
    var body: some View {
        NavigationView {
            VStack {
                CalendarView(calendar: Calendar(identifier: .gregorian))
            }
            .padding()
            .onAppear {
                viewModel.load()
            }
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
        
    }
}

#Preview {
    ContentView(viewModel: DLActivitiesViewModel())
}
