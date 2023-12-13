//
//  StreakView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct StreakView: View {
    
    @Binding var daysStreak: Int
    
    var body: some View {
        HStack {
            Text("Streaks")
            Spacer()
            Text("\(daysStreak)")
        }
        .padding()
    }
}

/*
#Preview {
    StreakView(daysStreak: 78)
}
*/
