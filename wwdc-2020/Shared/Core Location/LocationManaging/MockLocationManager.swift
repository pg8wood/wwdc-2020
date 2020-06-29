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
        
    init(authorizationStatus: CLAuthorizationStatus, accuracyAuthorization: CLAccuracyAuthorization) {
        self.authorizationStatus = authorizationStatus
        self.accuracyAuthorization = accuracyAuthorization
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        os_log("not implemented yet")
    }
}
