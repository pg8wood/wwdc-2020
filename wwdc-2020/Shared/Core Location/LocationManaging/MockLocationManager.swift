//
//  MockLocationManager.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import os
import CoreLocation
import MapKit

class MockLocationManager: LocationManaging {
    static var usaCoordinateRegion: MKCoordinateRegion = {
        let usaCenterCoordinate = CLLocationCoordinate2D(latitude: 37.0902, longitude: -95.7129)
        let usaCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 60)
        return MKCoordinateRegion(center: usaCenterCoordinate, span: usaCoordinateSpan)
    }()
    
    var authorizationStatus: CLAuthorizationStatus
    var accuracyAuthorization: CLAccuracyAuthorization
    var userCoordinateRegion: MKCoordinateRegion
        
    init(authorizationStatus: CLAuthorizationStatus,
         accuracyAuthorization: CLAccuracyAuthorization,
         userCoordinateRegion: MKCoordinateRegion = MockLocationManager.usaCoordinateRegion) {
        self.authorizationStatus = authorizationStatus
        self.accuracyAuthorization = accuracyAuthorization
        self.userCoordinateRegion = userCoordinateRegion
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        os_log("not implemented yet")
    }
}
