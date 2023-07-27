//
//  ViewModel.swift
//  tian qi
//
//  Created by bochain on 2023/7/18.
//

import Foundation




final class DataModel: ObservableObject {
    @Published var weather: Weather?
    @Published var forecastData: [String] = []
    @Published var labels: [String] = []
    @Published var test: String = "weather test"
    
    @Published var showError = false
    
    var error: Error? {
        willSet {
            DispatchQueue.main.async {
                self.showError = newValue != nil
            }
        }
    }
    enum FetchError: Error {
        case invalidURL
    }
    
    func fetch() {
        var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-069?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&format=JSON&locationId=F-D0047-071&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=WeatherDescription")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("TS01a5ae52=0107dddfef9e7bce02505436a2c8d666308ada74dacd618e24ac0f4f14aab5814dc7131309872f99a4f9d0609c823e3ccc6f77852b", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"
        print("request")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                print("fetch")
                let weatherData = try decoder.decode(Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weather = weatherData
                    self.error = nil
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
                    print(self.forecastData.prefix(5))
                    print(self.labels.prefix(5))
                }
            }catch {
                print("Error decoding data: \(error)")
                self.error = error
            }
        }
        task.resume()
    }
}
