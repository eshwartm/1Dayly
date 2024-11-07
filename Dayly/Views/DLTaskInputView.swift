//
//  DLTaskInputView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 07/11/24.
//

import SwiftUI

struct DLTaskInputView: View {
    @State private var task: String = ""
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true

    var body: some View {
        VStack {
            Text("Enter your task for today")
                .font(.headline)
                .padding()

            TextField("Your task", text: $task)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                // Save the task and mark the first launch as complete
                UserDefaults.standard.set(task, forKey: "userTask")
                isFirstLaunch = false
            }) {
                Text("Save Task")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    DLTaskInputView()
}
