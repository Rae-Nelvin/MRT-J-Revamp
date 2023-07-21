//
//  GeolocationViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 17/07/23.
//

import Foundation
import MapKit
import SwiftUI

class GeolocationViewModel: ObservableObject {
    @Published var streetName: String?
    @Published var clvm: CoreLocationViewModel = CoreLocationViewModel()
    @Published var closestDistances: Double?
    @Published var closestStationName: String?
    
    private let geocoder = CLGeocoder()
    private let stations: [Station] = stationLists.lists
    
    init() {
        clvm.locationManager.requestLocation()
        calculateClosestDistance()
    }
    
    func performReverseGeocoding() {
        let location = CLLocation(latitude: clvm.location?.coordinate.latitude ?? 0.0, longitude: clvm.location?.coordinate.longitude ?? 0.0)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else {
                print("Reverse geocoding failed with error: \(error?.localizedDescription ?? "")")
                return
            }
            
            self?.streetName = placemark.thoroughfare ?? ""
        }
    }
    
    func displayMap() -> some View {
        let coordinate = CLLocationCoordinate2D(latitude: clvm.location?.coordinate.latitude ?? 0.0, longitude: clvm.location?.coordinate.longitude ?? 0.0)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        return Map(coordinateRegion: .constant(region))
    }
    
    func calculateClosestDistance() {
        let closestStation = stations.min { (station1, station2) -> Bool in
            let location1 = CLLocation(latitude: station1.latitude, longitude: station1.longitude)
            let location2 = CLLocation(latitude: station2.latitude, longitude: station2.longitude)
            return clvm.locationManager.location?.distance(from: location1) ?? 0.0 < clvm.locationManager.location?.distance(from: location2) ?? 0.0
        }
        
        if let closestStation = closestStation {
            let closestLocation = CLLocation(latitude: closestStation.latitude, longitude: closestStation.longitude)
            let distance = (clvm.locationManager.location?.distance(from: closestLocation) ?? 0.0) / 1000.0
            closestDistances = distance
            closestStationName = closestStation.name
        }
    }
    
}
