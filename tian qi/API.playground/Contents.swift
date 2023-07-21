import Foundation
let chineseString = "新北市"
let utf8Data = chineseString.data(using: .utf8)
var locationName = "%"

if let utf8Bytes = utf8Data {
    locationName.append(utf8Bytes.map { String(format: "%02X", $0) }.joined(separator: "%"))
    print(locationName) // Output: E8% B6% BA% E5% 8C% 97% E5% B8% 82
}

var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=\(locationName)")!,timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
  print(String(data: data, encoding: .utf8)!)
}

task.resume()
