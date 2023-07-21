//
//  ViewModel.swift
//  tian qi
//
//  Created by bochain on 2023/7/18.
//

import Foundation
import SwiftUI

struct CurrentWeather{
    var locationName: String?
    var Wx: String?
    var MaxT: String?
    var MinT: String?
    var PoP: String?
}


class DataModel: ObservableObject {
    @Published var weather: Weather?
    @Published var locations: [Location] = []
    @Published var currentweather: CurrentWeather?
    @Published var aaa: [WeatherElement] = []
    
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
    
    
    func fetchLocation(locationName: String) {
        //let locationName = "新北市"
        var Wx = ""
        var PoP = ""
        var MaxT = ""
        var MinT = ""
        var urlComponents = URLComponents()
        urlComponents.host = "opendata.cwb.gov.tw"
        urlComponents.scheme = "https"
        urlComponents.path = "/api/v1/rest/datastore/F-C0032-001"
        urlComponents.query = "Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=\(locationName)"
        
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                print("aaa")
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherData = try decoder.decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    let element: [WeatherElement] = weatherData.records.location.first?.weatherElement.map() { elements in
                        if elements.elementName == "Wx" {
                            if let wx = elements.time.first?.parameter.parameterName {
                                Wx = wx
                                print(wx)
                                
                            }
                        }
                        if elements.elementName == "PoP" {
                            if let Pop = elements.time.first?.parameter.parameterName{
                                PoP = Pop
                                print(Pop)
                            }
                        }
                        if elements.elementName == "MinT" {
                            if let temperature = elements.time.first?.parameter.parameterName{
                                MinT = temperature
                                print(temperature)
                            }
                               
                        }
                        if elements.elementName == "MaxT" {
                            if let temperature = elements.time.first?.parameter.parameterName{
                                MaxT = temperature
                                print(temperature)
                            }
                        }
                    } as! [WeatherElement]
                    self.currentweather = CurrentWeather(locationName: locationName, Wx: Wx, MaxT: MaxT, MinT: MinT, PoP: PoP)
                    self.aaa = element
                    
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        
        task.resume()
    }
}

