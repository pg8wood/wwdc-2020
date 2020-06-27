//
//  SettingsView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI

struct SettingsView: View {
    
    private let colors: [Color] = [
        .blue,
        .red,
        .green,
        .purple,
        .orange
    ]
    
    @Binding var accentColor: Color
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Label("Accent Color", systemImage: "paintbrush")
                    .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
                    .foregroundColor(accentColor)
                
                Picker("Accent color", selection: $accentColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color.description)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // The current ColorPicker is not dismissable on the iOS 14.0 beta at the time of writing
                // ColorPicker("Tint color", selection: $tintColor)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Settings")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(accentColor: .constant(.purple))
    }
}
