//
//  LocationManager.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import Combine
import CoreLocation
import os

class LocationManager: NSObject, LocationManaging, CLLocationManagerDelegate {
    private(set) var locationManager = CLLocationManager()
        
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    // MARK: - LocationManaging
    
    typealias AuthorizationStatus = CLAuthorizationStatus
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var accuracyAuthorization: CLAccuracyAuthorization = .reducedAccuracy
    {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var lastLocation: CLLocation? {
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
        
        locationManager.startUpdatingLocation()
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
        
        let accuracyAuthorization = manager.accuracyAuthorization
        self.accuracyAuthorization = accuracyAuthorization
        // TODO
        switch accuracyAuthorization {
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
