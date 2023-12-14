//
//  AddDailyActivityView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct AddDailyActivityView: View {
    
    @State var title: String
    @State var description: String = "Description"
    @State var date: Date
    @State var reminder: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title of Activity", text: $title)
                TextEditor(text: $description)
                    .frame(height: 300)
                DatePicker("Date", selection: $date)
                DLSettingSwitchToggleView(title: "Need a Reminder?")
            }
            .padding()
            .navigationTitle("Add")
        }
    }
}

#Preview {
    AddDailyActivityView(title: "", description: "Add a Description...", date: Date(), reminder: true)
}
