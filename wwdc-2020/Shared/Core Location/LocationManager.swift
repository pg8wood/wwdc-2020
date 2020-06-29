//
//  LocationManager.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import Combine
import CoreLocation
import os

enum LocationAuthorizationRequestType {
    case always
    case whenInUse
}

protocol LocationManaging: ObservableObject, Identifiable {
    var authorizationStatus: CLAuthorizationStatus? { get }
    var authorizationStatusDescription: String { get }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType)
}

class MockLocationManager: LocationManaging {
    var authorizationStatus: CLAuthorizationStatus?
    
    var authorizationStatusDescription: String {
        "Not implemented yet"
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        // woo
    }
}

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    private(set) var locationManager = CLLocationManager()
    
    var authorizationStatusDescription: String {
        switch authorizationStatus {
        case .notDetermined: return "Not determined"
        case .authorizedWhenInUse: return "Authorized when in use"
        case .authorizedAlways: return "Authorized always"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        default: return "unknown 🤷‍♀️"
        }
    }
    
    // MARK: - Publishers
    
    let objectWillChange = PassthroughSubject<Void, Never>()
        
    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }
        
    
    // MARK: - LocationManaging
    
    typealias AuthorizationStatus = CLAuthorizationStatus
    
    @Published var authorizationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }
    
    func requestAuthorization(_ type: LocationAuthorizationRequestType) {
        switch type {
        case .always:
            locationManager.requestAlwaysAuthorization()
        case .whenInUse:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - init
    
    override init() {
        super.init()
        locationManager.delegate = self
        
        // TODO do different types. Don't forget to add the corresponding values to Info.plist!
        // example https://stackoverflow.com/questions/57681885/how-to-get-current-location-using-swiftui-without-viewcontrollers
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
     // MARK: - CLLocationManagerDelegate
    
     func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus()
        self.authorizationStatus = authorizationStatus
        // TODO
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .notDetermined, .denied:
            break
        case .restricted:
            break
        @unknown default:
            os_log("unknown authorization case")
        }
        
        // TODO
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            break
        case .reducedAccuracy:
            break
        @unknown default:
            os_log("unknown accuracy authorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
    }
}
