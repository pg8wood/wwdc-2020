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
        VStack(alignment: .leading) {
            WWDCLink(title: "Data Essentials in SwiftUI", url: "https://developer.apple.com/wwdc20/10040")
            
            AccentColorPickerView()
            
            // The current ColorPicker is not dismissable on the iOS 14.0 beta at the time of writing
            // ColorPicker("Tint color", selection: $tintColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
        .navigationTitle("Persistence")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AccentColorPickerView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("Accent Color", systemImage: "paintbrush")
                .labelStyle(VerticallyCenteredLabelImageAlignmentStyle())
                .foregroundColor(userSettings.accentColor)
            
            Picker("Accent color", selection: $userSettings.accentColorString) {
                ForEach(AccentColor.allCases, id: \.self) { colorSetting in
                    Text(colorSetting.color.description).tag(colorSetting.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            AutoColorUpdateSettingsView()
        }
    }
}

struct AutoColorUpdateSettingsView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Group {
            Toggle(isOn: $userSettings.autoUpdateAccentColor) {
                Text("Change colors automatically")
            }
            
            if userSettings.autoUpdateAccentColor {
                HStack {
                    Stepper(value: $userSettings.autoUpdateAccentColorInterval, in: 0.25...10, step: 0.25) {
                        Text("Update color every \(userSettings.autoUpdateAccentColorInterval, specifier: "%.2f") seconds")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(UserSettings())
    }
}
