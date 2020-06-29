//
//  LocationPermissionsView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import SwiftUI

struct LocationPermissionsView<LocationManagerType: LocationManaging>: View {
    @EnvironmentObject var locationManager: LocationManagerType
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Location permissions: \(locationManager.authorizationStatusDescription)")
                .font(.caption)
            
            if case .denied = locationManager.authorizationStatus {
                WWDCLink(title: "Open Settings", url: UIApplication.openSettingsURLString, image: "gear")
            }
            
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color(UIColor.secondarySystemBackground))
        .onAppear {
            locationManager.requestAuthorization(.whenInUse)
        }
    }
}

struct LocationPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationPermissionsView<MockLocationManager>()
                .environmentObject(MockLocationManager(authorizationStatus: .authorizedAlways))
            
            LocationPermissionsView<MockLocationManager>()
                .environmentObject(MockLocationManager(authorizationStatus: .denied))
            
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(UserSettings())
    }
}
