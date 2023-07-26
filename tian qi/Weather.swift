//
//  Weather.swift
//  tian qi
//
//  Created by bochain on 2023/7/19.
//

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
