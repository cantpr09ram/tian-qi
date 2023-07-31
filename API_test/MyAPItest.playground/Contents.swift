import Foundation

struct Weather: Codable {
    var records: WeatherRecords
}

struct WeatherRecords: Codable {
    var locations: [Locations]
}

struct Locations: Codable{
    var datasetDescription: String
    var locationsName: String
    var location: [Location]
    
}

struct Location: Codable{
    var locationName: String
    var weatherElement: [WeatherElement]
}

struct WeatherElement: Codable {
    var elementName: String
    var description: String
    var time: [ForecastTime]
}

struct ForecastTime: Codable {
    let startTime: String
    let endTime: String
    let elementValue: [ElementValue]
}

struct ElementValue: Codable {
    let value: String
    let measures: String
}



var weather: Weather?
var forecastData: [String] = []
var MaxT: [String] = []
var MinT: [String] = []
var labels: [String] = []

var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-071?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=MinT%2CMaxT%2CWx")!,timeoutInterval: Double.infinity)
request.addValue("application/json", forHTTPHeaderField: "accept")
request.addValue("TS01a5ae52=0107dddfefcc361df4e6c96cef846097a3593b13a9e1d204a0a3abe912498a931a4fdb4171e92f4eea0c5c330ff72cad25191aecb6", forHTTPHeaderField: "Cookie")

request.httpMethod = "GET"
let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
    //print(data)
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        print("fetch")
        let weatherData = try decoder.decode(Weather.self, from: data)
        
        DispatchQueue.main.async {
            weather = weatherData
            
            for locations in weatherData.records.locations {
                for location in locations.location{
                    for weatherElement in location.weatherElement {
                        if weatherElement.elementName == "Wx" {
                            for forecastTime in weatherElement.time {
                                for elementValue in forecastTime.elementValue {
                                    // Extract temperature and probability of precipitation data
                                    if elementValue.measures == "自定義 Wx 文字" {
                                        forecastData.append(elementValue.value)
                                    }
                                    // Use startTime as the label for the x-axis
                                    labels.append(forecastTime.startTime)
                                }
                            }
                        }else if weatherElement.elementName == "MaxT"{
                            for forecastTime in weatherElement.time {
                                for elementValue in forecastTime.elementValue {
                                    // Extract temperature and probability of precipitation data
                                    if elementValue.measures == "攝氏度"{
                                        MaxT.append(elementValue.value)
                                    }
                                    // Use startTime as the label for the x-axis
                                }
                            }
                        }else if weatherElement.elementName == "MinT"{
                            for forecastTime in weatherElement.time {
                                for elementValue in forecastTime.elementValue {
                                    // Extract temperature and probability of precipitation data
                                    if elementValue.measures == "攝氏度"{
                                        MinT.append(elementValue.value)
                                    }
                                    // Use startTime as the label for the x-axis
                                }
                            }
                        }
                    }
                }
            }
            print(forecastData[0])
            print(MaxT[0])
            print(MinT[0])
        }
    }catch {
        print("Error decoding JSON: \(error)")
    }

}

task.resume()

