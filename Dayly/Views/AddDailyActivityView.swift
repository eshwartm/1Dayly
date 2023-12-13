//
//  AddDailyActivityView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct AddDailyActivityView: View {
    
    @State var title: String
    @State var description: String?
    @State var date: Date
    @State var reminder: Bool
    
    var body: some View {
        VStack {
            TextField("Title of Activity", text: $title)
            TextEditor(text: .constant("Description"))
            DatePicker("Date", selection: $date)
            DLSettingSwitchToggleView(title: "Need a Reminder?")
        }
    }
}

#Preview {
    AddDailyActivityView(title: "", date: Date(), reminder: true)
}
