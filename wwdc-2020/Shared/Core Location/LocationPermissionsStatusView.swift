//
//  LocationPermissionsView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import SwiftUI

struct LocationPermissionsStatusView<LocationManagerType: LocationManaging>: View {
    @EnvironmentObject var locationManager: LocationManagerType
    
    private var preciseLocationDescription: String {
        "Precise Location: \(locationManager.accuracyAuthorization == .fullAccuracy ? "on" : "off")"
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Location permissions: \(locationManager.authorizationStatus.description)")
                .font(.caption)
            
            if locationManager.authorizationStatus != .denied {
                Text(preciseLocationDescription)
                    .font(.caption)
            }
            
//            WWDCLink(title: "Change Location Settings", url: UIApplication.openSettingsURLString, image: "gear")
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
//        .background(Color(UIColor.secondarySystemBackground))
        .onAppear {
            locationManager.requestAuthorization(.whenInUse)
        }
    }
}

struct LocationPermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationPermissionsStatusView<MockLocationManager>()
                .environmentObject(MockLocationManager(authorizationStatus: .denied))
            
            LocationPermissionsStatusView<MockLocationManager>()
                .environmentObject(MockLocationManager(authorizationStatus: .authorizedAlways,
                                                       accuracyAuthorization: .fullAccuracy))
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(UserSettings())
    }
}
