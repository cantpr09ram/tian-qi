//
//  FetchLatitudeandLongitude.swift
//  tian qi
//
//  Created by bochain on 2023/7/24.
//

import Foundation

import CoreLocation
import _CoreLocationUI_SwiftUI

class FetchLatitudeandLongitude: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location update errors here
        print("Location update failed with error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) -> () {
        if let location = locations.last?.coordinate {
            self.location = location
            print("get location")
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
