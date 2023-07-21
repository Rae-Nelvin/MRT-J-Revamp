//
//  StationModels.swift
//  MRT-J
//
//  Created by Leonardo Wijaya on 17/07/23.
//

import Foundation

struct Station: Identifiable{
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct stationLists {
    static let lists: [Station] = [
        Station(name: "Lebak Bulus Grab", latitude: -6.289361581369295, longitude:  106.77411877729375),
        Station(name: "Fatmawati", latitude: -6.29233267870528, longitude: 106.79289988304943),
        Station(name: "Cipete Raya", latitude: -6.278104616151923, longitude: 106.79798718927083),
        Station(name: "Haji Nawi", latitude: -6.266510647480234, longitude: 106.7980622625107),
        Station(name: "Blok A", latitude: -6.255571978823519, longitude: 106.79788572020587),
        Station(name: "Blok M BCA", latitude: -6.244331332649756, longitude: 106.79930163398298),
        Station(name: "Asean", latitude: -6.23820139712473, longitude: 106.79884060919622),
        Station(name: "Senayan", latitude: -6.226537939407252, longitude: 106.80296019807083),
        Station(name: "Istora Mandiri", latitude: -6.222137304489382, longitude: 106.80938263548595),
        Station(name: "Bendungan Hilir", latitude: -6.214871994696852, longitude:  106.81856154505303),
        Station(name: "Setiabudi Astra", latitude: -6.208682460042654, longitude: 106.82264328920336),
        Station(name: "Dukuh Atas BNI", latitude: -6.200658526399624, longitude:  106.82320379630734),
        Station(name: "Bundaran HI", latitude: -6.1916572930385225, longitude: 106.8235240289828),
        Station(name: "Academy Station", latitude: -6.302092748372923, longitude: 106.652895630444) // Testing purposes
    ]
}
