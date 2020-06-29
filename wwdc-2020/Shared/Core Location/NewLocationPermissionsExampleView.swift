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
    @State private var locationType: LocationAuthorizationRequestType = .whenInUse
    
    // TODO locationmanaging
    @ObservedObject var locationManager = LocationManager()
    
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
        ZStack(alignment: .top) {
            MapView()
            
            LocationPermissionsView<LocationManager>()
                .environmentObject(locationManager)
        }
        .navigationTitle("MapKit")
        .navigationBarItems(trailing: infoButton)
        .navigationBarTitleDisplayMode(.inline)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NewLocationPermissionsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewLocationPermissionsExampleView()
                .environmentObject(UserSettings())
        }
    }
}
