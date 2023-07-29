import Foundation

struct ResponseData: Codable {
    let success: String
    let result: Result
    let records: Records
}

struct Result: Codable {
    let resource_id: String
    let fields: [Field]
}

struct Field: Codable {
    let id: String
    let type: String
}

struct Records: Codable {
    let location: [Location]
}

struct Location: Codable {
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
        let responseData = try decoder.decode(ResponseData.self, from: data)
        
        for location in responseData.records.location {
            let locationName = location.locationName
            let geocode = location.geocode
            if location.hazardConditions.hazards.count > 0{
                for hazardInfo in location.hazardConditions.hazards {
                    let language = hazardInfo.info.language
                    let phenomena = hazardInfo.info.phenomena
                    let significance = hazardInfo.info.significance
                    let startTime = hazardInfo.validTime.startTime
                    let endTime = hazardInfo.validTime.endTime
                    print(phenomena, significance, startTime, endTime)
                        // Now you can use the extracted data as needed
                        // For example, you can display it on the screen or perform any other operations.
                }
            }
        }
            
    } catch {
        print("Error decoding JSON: \(error)")
    }

}

task.resume()

