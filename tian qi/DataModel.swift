//
//  ViewModel.swift
//  tian qi
//
//  Created by bochain on 2023/7/18.
//

import Foundation




class DataModel: ObservableObject {
    @Published var weather: Weather?
    @Published var forecastData: [String] = []
    @Published var labels: [String] = []
    
    @Published var test: String = "weather test"
    
    func fetch() {
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
                    for locations in weatherData.records.locations {
                        for location in locations.location{
                            for weatherElement in location.weatherElement {
                                if weatherElement.elementName == "WeatherDescription" {
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "NA" {
                                                self.forecastData.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                            self.labels.append(forecastTime.startTime)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    print(self.forecastData[0])
                    print(self.labels[0])
                }
            }catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}
