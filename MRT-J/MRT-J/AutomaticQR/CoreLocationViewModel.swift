//
//  CoreLocationViewModel.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 15/07/23.
//

import Foundation
import CoreLocation

class CoreLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            print("Authorized")
            authorizationStatus = .authorizedWhenInUse
            break
            
        case .restricted:
            print("Restricted")
            authorizationStatus = .restricted
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            print("Denied")
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            print("Not Determined")
            manager.requestWhenInUseAuthorization()
            authorizationStatus = .notDetermined
            break
            
        default:
            break
        }
    }
    
    
    
}

extension CoreLocationViewModel {
    // MARK: Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}
