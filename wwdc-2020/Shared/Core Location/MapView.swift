//
//  MapView.swift
//  wwdc-2020
//
//  Created by Patrick Gatewood on 6/28/20.
//

import os
import SwiftUI
import MapKit

struct MapView<LocationManagerType: LocationManaging>: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManagerType
    
    private var mapRegionDistance: CLLocationDistance {
        if locationManager.accuracyAuthorization == .fullAccuracy {
            return CLLocationDistance(exactly: 5000)!
        } else {
            return CLLocationDistance(exactly: 8000)!
        }
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        guard let userCoordinate = locationManager.lastLocation?.coordinate else {
            os_log("failed to get user's location")
            return
        }
        
        let region = MKCoordinateRegion(center: userCoordinate,
                                        latitudinalMeters: mapRegionDistance,
                                        longitudinalMeters: mapRegionDistance)
        
        view.setRegion(view.regionThatFits(region), animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}
