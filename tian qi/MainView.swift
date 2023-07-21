//
//  MainView.swift
//  tian qi
//
//  Created by bochain on 2023/7/19.
//

import SwiftUI
import CoreLocation
import _CoreLocationUI_SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            self.location = location
        }
    }
}

struct MainView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.location {
                Text("Your location: \(location.latitude), \(abs(location.longitude))")
            }
        }
        .onAppear{
            locationManager.requestLocation()
        }
    }
}
 

/*
 WX:天氣狀況
 Pop:降雨
 MinT: 最低溫
 MaxT: 最高溫
 CI: 舒適度
 */
