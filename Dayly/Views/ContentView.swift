//
//  ContentView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: DLActivitiesViewModel
    
    var body: some View {
        VStack {
            CalendarView(calendar: Calendar(identifier: .gregorian))
        }
        .padding()
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    ContentView(viewModel: DLActivitiesViewModel())
}
