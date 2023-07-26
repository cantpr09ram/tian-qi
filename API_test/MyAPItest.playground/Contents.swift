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
    var startTime: String
    var endTime: String
    var elementValue: [ElementValue]
}

struct ElementValue: Codable {
    var value: String
    var measures: String
}

var forecastData: [String] = []
var labels: [String] = []

var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-069?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&format=JSON&locationId=F-D0047-071&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=WeatherDescription")!,timeoutInterval: Double.infinity)
request.addValue("application/json", forHTTPHeaderField: "accept")
request.addValue("TS01a5ae52=0107dddfef9e7bce02505436a2c8d666308ada74dacd618e24ac0f4f14aab5814dc7131309872f99a4f9d0609c823e3ccc6f77852b", forHTTPHeaderField: "Cookie")

request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
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
                                        forecastData.append(elementValue.value)
                                    }
                                    // Use startTime as the label for the x-axis
                                    labels.append(forecastTime.startTime)
                                }
                            }
                        }
                    }
                }
            }
            print(forecastData[0])
            print(labels[0])
        }
    }catch {
        print("Error decoding data: \(error)")
    }
    
    //print(String(data: data, encoding: .utf8)!)
}

task.resume()

