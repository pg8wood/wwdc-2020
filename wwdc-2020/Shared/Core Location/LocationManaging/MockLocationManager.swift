//
//  MockLocationManager.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import os
import CoreLocation

class MockLocationManager: LocationManaging {
    var authorizationStatus: CLAuthorizationStatus
    var accuracyAuthorization: CLAccuracyAuthorization
    var lastLocation: CLLocation?
        
    init(authorizationStatus: CLAuthorizationStatus,
         accuracyAuthorization: CLAccuracyAuthorization,
         lastLocation: CLLocation? = nil) {
        self.authorizationStatus = authorizationStatus
        self.accuracyAuthorization = accuracyAuthorization
        self.lastLocation = lastLocation
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        os_log("not implemented yet")
    }
}
