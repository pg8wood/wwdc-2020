//
//  MapView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import os
import SwiftUI
import MapKit

struct MapView<LocationManagerType: LocationManaging>: View {
    @EnvironmentObject var locationManager: LocationManagerType
    
    @State private var userTrackingMode: MapUserTrackingMode = .none
        
    var body: some View {
        Map(coordinateRegion: $locationManager.userCoordinateRegion, showsUserLocation: true, userTrackingMode: $userTrackingMode)
    }
}
