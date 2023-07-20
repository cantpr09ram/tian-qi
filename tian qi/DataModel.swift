//
//  ViewModel.swift
//  tian qi
//
//  Created by bochain on 2023/7/18.
//

import Foundation
import SwiftUI


class DataModel: ObservableObject {
    @Published var weather: Weather?
    @Published var locations: [Location] = []
    
    func fetch(now: String) {
        guard let url = URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weather = weatherData
                    let locations: [Location] = weatherData.records.location.map() { locations in
                        Location(locationName: locations.locationName, weatherElement: locations.weatherElement)
                    }
                    self.locations = locations
                    
                    print(locations[0])
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
}

