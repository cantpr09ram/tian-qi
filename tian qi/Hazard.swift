//
//  Hazard.swift
//  tian qi
//
//  Created by bochain on 2023/7/28.
//

import Foundation

struct Hazard: Codable {
    let success: String
    let result: Result
    let records: Hrecords
}

struct Result: Codable {
    let resource_id: String
    let fields: [Field]
}

struct Field: Codable {
    let id: String
    let type: String
}

struct Hrecords: Codable {
    let location: [HLocation]
}

struct HLocation: Codable {
    let locationName: String
    let geocode: Double
    let hazardConditions: HazardConditions
}

struct HazardConditions: Codable {
    let hazards: [HazardInfo]
}

struct HazardInfo: Codable {
    struct Info: Codable {
        let language: String
        let phenomena: String
        let significance: String
    }
    
    struct ValidTime: Codable {
        let startTime: String
        let endTime: String
    }
    
    let info: Info
    let validTime: ValidTime
}

