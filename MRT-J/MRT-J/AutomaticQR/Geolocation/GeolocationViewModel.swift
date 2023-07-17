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
    
    @Published var coreLocationVM = CoreLocationViewModel()
    private let geocoder = CLGeocoder()
    
    init() {
        coreLocationVM.locationManager.requestLocation()
    }
    
    func performReverseGeocoding() {
        let location = CLLocation(latitude: coreLocationVM.latitude ?? 0.0, longitude: coreLocationVM.longitude ?? 0.0)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else {
                print("Reverse geocoding failed with error: \(error?.localizedDescription ?? "")")
                return
            }
            
            self?.streetName = placemark.thoroughfare ?? ""
        }
    }
    
    func displayMap() -> some View {
        let coordinate = CLLocationCoordinate2D(latitude: coreLocationVM.latitude ?? 0.0, longitude: coreLocationVM.longitude ?? 0.0)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        return Map(coordinateRegion: .constant(region))
    }
    
}
