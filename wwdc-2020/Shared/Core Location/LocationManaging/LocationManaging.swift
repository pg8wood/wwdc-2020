//
//  LocationManaging.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/29/20.
//

import CoreLocation

enum LocationAuthorizationRequestType {
    case always
    case whenInUse
}

protocol LocationManaging: ObservableObject, Identifiable {
    var authorizationStatus: CLAuthorizationStatus { get }
    var accuracyAuthorization: CLAccuracyAuthorization { get }
    var lastLocation: CLLocation? { get }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType)
}

extension CLAuthorizationStatus {
    var description: String {
        switch self {
        case .notDetermined: return "Not determined"
        case .authorizedWhenInUse: return "Authorized when in use"
        case .authorizedAlways: return "Authorized always"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        default: return "unknown 🤷‍♀️"
        }
    }
}
