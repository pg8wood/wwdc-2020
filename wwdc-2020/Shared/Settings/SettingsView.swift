//
//  SettingsView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/27/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                AccentColorPickerView(accentColorString: $userSettings.accentColorString)
    
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

struct AccentColorPickerView: View {
    @Binding var accentColorString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("Accent Color", systemImage: "paintbrush")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
                .foregroundColor(AccentColor(rawValue: accentColorString)?.color ?? .blue)
            
            Picker("Accent color", selection: $accentColorString) {
                ForEach(AccentColor.allCases, id: \.self) { colorSetting in
                    Text(colorSetting.color.description).tag(colorSetting.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
    }
}


