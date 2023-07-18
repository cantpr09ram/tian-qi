import Foundation

var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258")!,timeoutInterval: Double.infinity)
request.addValue("TS01a5ae52=0107dddfefa635264857de4b13f8d79655d40d91c26a0e4abb4a9410758a7a91936dc0f887b5f6e53dda20bf95bcea7fd6d3bcc700", forHTTPHeaderField: "Cookie")

request.httpMethod = "GET"

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  guard let data = data else {
    print(String(describing: error))
    return
  }
  print(String(data: data, encoding: .utf8)!)
}

task.resume()

