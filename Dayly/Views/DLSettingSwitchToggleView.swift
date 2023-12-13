//
//  DLSettingSwitchToggleView.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 12/12/23.
//

import SwiftUI

struct DLSettingSwitchToggleView: View {
    
    var title: String
    @State private var setting = true
    
    var body: some View {
        HStack {
            Toggle(title, isOn: $setting)
            
            if setting {
                // do something
               
            } else {
               
            }
        }
    }
}

#Preview {
    DLSettingSwitchToggleView(title: "title")
}
