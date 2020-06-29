//
//  MockLocationManager.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import os
import CoreLocation

class MockLocationManager: LocationManaging {
    var authorizationStatus: CLAuthorizationStatus?
        
    init(authorizationStatus: CLAuthorizationStatus?) {
        self.authorizationStatus = authorizationStatus
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        os_log("not implemented yet")
    }
}
