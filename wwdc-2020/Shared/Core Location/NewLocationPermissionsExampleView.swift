//
//  NewLocationPermissionsExampleView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import SwiftUI

struct NewLocationPermissionsExampleView<LocationManagerType: LocationManaging>: View {
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var locationManager: LocationManagerType
    
    @State private var isInfoSheetPresented = false
    @State private var locationType: LocationAuthorizationRequestType = .whenInUse
    
    var infoButton: some View {
        func buttonActions() {
            isInfoSheetPresented = true
        }
        
        return Button {
            buttonActions()
        } label: {
            Image(systemName: "info.circle.fill")
                .foregroundColor(userSettings.accentColor)
        }
        .frame(width: 35, height: 35, alignment: .trailing)
        .contentShape(Rectangle())
        .onTapGesture {
            buttonActions()
        }
        .popover(isPresented: $isInfoSheetPresented) {
            PermissionsInfoPopoverView(isPresented: $isInfoSheetPresented)
                .onDisappear {
                    isInfoSheetPresented = false
                }
                
                // It seems popovers doesn't get passed @EnvironmentObjects
                // under-the-hood. Not sure if this a bug or not.
                .environmentObject(userSettings)
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            MapView<LocationManager>()
                .environmentObject(locationManager)
            LocationPermissionsStatusView<LocationManager>()
                .environmentObject(locationManager)
        }
        .navigationTitle("MapKit")
        .navigationBarItems(trailing: infoButton)
        .navigationBarTitleDisplayMode(.inline)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea([.leading, .trailing, .bottom])
    }
}

struct NewLocationPermissionsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewLocationPermissionsExampleView<MockLocationManager>()
                .environmentObject(UserSettings())
                .environmentObject(MockLocationManager(authorizationStatus: .denied, accuracyAuthorization: .fullAccuracy))
        }
        .previewLayout(.sizeThatFits)
    }
}
