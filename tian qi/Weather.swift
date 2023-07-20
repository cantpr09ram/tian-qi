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

struct Location: Codable, Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(locationName)
    }
        
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.locationName == rhs.locationName
    }
    
    var locationName: String
    var weatherElement: [WeatherElement]
}

struct WeatherElement: Codable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(elementName)
    }
        
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.elementName == rhs.elementName
    }
    
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
