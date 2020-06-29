//
//  NewLocationPermissionsExampleView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import SwiftUI

struct NewLocationPermissionsExampleView: View {
    @EnvironmentObject var userSettings: UserSettings
    
    @State private var isInfoSheetPresented = false
    
    var infoButton: some View {
        Button {
            isInfoSheetPresented = true
        } label: {
            Image(systemName: "info.circle.fill")
                .foregroundColor(userSettings.accentColor)
        }
        .popover(isPresented: $isInfoSheetPresented) {
            NewLocationPermissionsInfoView(isPresented: $isInfoSheetPresented)
                .onDisappear {
                    isInfoSheetPresented = false
                }
                
                // It seems popovers doesn't get passed @EnvironmentObjects
                // under-the-hood. Not sure if this a bug or not.
                .environmentObject(userSettings)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("test this is a long lable here ok thanks")
            MapView()
        }
        .navigationTitle("MapKit")
        .navigationBarItems(trailing: infoButton)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        
    }
}

struct NewLocationPermissionsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NewLocationPermissionsExampleView()
            .environmentObject(UserSettings())
    }
}
