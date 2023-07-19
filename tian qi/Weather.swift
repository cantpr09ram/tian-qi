//
//  Weather.swift
//  tian qi
//
//  Created by bochain on 2023/7/19.
//

import Foundation

struct Weather: Codable {
    var records: WeatherRecords
}

struct WeatherRecords: Codable {
    var datasetDescription: String
    var location: [Location]
}

struct Location: Codable {
    var locationName: String
    var weatherElement: [WeatherElement]
}

struct WeatherElement: Codable {
    var elementName: String
    var time: [Time]
}

struct Time: Codable {
    var startTime: String
    var endTime: String
    var parameter: Parameter
}

struct Parameter: Codable {
    var parameterName: String
    var parameterValue: String?
    var parameterUnit: String?
}
