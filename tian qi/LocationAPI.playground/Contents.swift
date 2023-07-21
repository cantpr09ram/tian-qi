import Foundation

var latitude = 24.156250 // 緯度
var longitude = 120.698659 // 經度

var request = URLRequest(url: URL(string: "https://api.nlsc.gov.tw/other/TownVillagePointQuery/\(longitude)/\(latitude)")!, timeoutInterval: Double.infinity)
request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
    guard let data = data else {
        print(String(describing: error))
        return
    }
    print(String(data: data, encoding: .utf8)!)
}

task.resume()
