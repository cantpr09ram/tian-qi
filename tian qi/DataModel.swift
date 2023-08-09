//
//  ViewModel.swift
//  tian qi
//
//  Created by bochain on 2023/7/18.
//

import Foundation

final class DataModel: ObservableObject {
    //2 day weather forecast
    @Published var weather: Weather?
    @Published var forecastData: [String] = []
    @Published var labels: [String] = []
    @Published var test: String = "weather test"
    //hazard
    @Published var hazard: Hazard?
    @Published var hazardList: [HazardInfo] = []
    //7Day weather forecast
    @Published var weekweather: Weather?
    @Published var labels7: [String] = []
    @Published var Wx: [String] = []
    @Published var MaxT: [String] = []
    @Published var MinT: [String] = []
    @Published var Pop12h: [String] = []
    
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
    
    func fetch2Day() {
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
                    //print(self.forecastData.prefix(5))
                    //print(self.labels.prefix(5))
                }
            }catch {
                print("Error decoding data: \(error)")
                self.error = error
            }
        }
        task.resume()
    }
    
    func fetchHazard(){
        var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/W-C0033-001?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=%E6%96%B0%E5%8C%97%E5%B8%82")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("TS01a5ae52=0107dddfef8722b8017a7a3e1534d9cdf5a189e1d330d1baa73da3ee4313a7b9097e3df4b62f2667a9b8abc2d6169d58d6cc1320fb", forHTTPHeaderField: "Cookie")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            //print(data)
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(Hazard.self, from: data)
                self.hazard = responseData
                for location in responseData.records.location {
                    if location.hazardConditions.hazards.count > 0{
                        self.hazardList = location.hazardConditions.hazards
                       
                        print(self.hazardList[0])
                    }
                }
                    
            } catch {
                print("Error decoding JSON: \(error)")
            }

        }

        task.resume()
    }
    
    func fetch7Day() {
        var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-071?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=MinT%2CMaxT%2CWx%2CPoP12h")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("TS01a5ae52=0107dddfefee342a916fa607cb3c4574085e6a8f2f8aad5d6fe6e0b421c733b841abc5e593b937691c469fdc44c804636189f4892f", forHTTPHeaderField: "Cookie")
        
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
                    self.weekweather = weatherData
                    self.error = nil
                    for locations in weatherData.records.locations {
                        for location in locations.location{
                            for weatherElement in location.weatherElement {
                                if weatherElement.elementName == "Wx" {
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "自定義 Wx 文字" {
                                                self.Wx.append(elementValue.value)
                                                self.labels7.append(forecastTime.startTime)
                                            }
                                            // Use startTime as the label for the x-axis
                                            //self.labels7.append(forecastTime.startTime)
                                        }
                                    }
                                }else if weatherElement.elementName == "MaxT"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "攝氏度"{
                                                self.MaxT.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }else if weatherElement.elementName == "MinT"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "攝氏度"{
                                                self.MinT.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }else if weatherElement.elementName == "PoP12h"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "百分比"{
                                                if elementValue.value == " "{
                                                    self.Pop12h.append("0")
                                                }else{
                                                    self.Pop12h.append(elementValue.value)
                                                }
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //print(self.forecastData.prefix(5))
                    print(self.labels7.count)
                    print(self.Pop12h.count)
                }
            }catch {
                print("Error decoding data: \(error)")
                self.error = error
            }
        }
        task.resume()
    }
}
