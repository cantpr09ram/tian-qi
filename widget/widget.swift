//
//  widget.swift
//  widget
//
//  Created by bochain on 2023/8/10.
//

import WidgetKit
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var weekweather: SimpleEntry.Weather?
    @Published var labels7: [String] = []
    @Published var Wx: [String] = []
    @Published var MaxT: [String] = []
    @Published var MinT: [String] = []
    @Published var Pop12h: [String] = []
    
    @Published var weather: SimpleEntry.Weather?
    @Published var forecastData: [String] = []
    @Published var labels: [String] = []
    
    func getCurrentData(completion: @escaping (SimpleEntry.Weather?) -> Void){
        var request = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-071?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=MinT%2CMaxT%2CWx%2CPoP12h")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("TS01a5ae52=0107dddfefee342a916fa607cb3c4574085e6a8f2f8aad5d6fe6e0b421c733b841abc5e593b937691c469fdc44c804636189f4892f", forHTTPHeaderField: "Cookie")
        
        request.httpMethod = "GET"
        print("request")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print("fetch")
                let weatherData = try decoder.decode(SimpleEntry.Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weekweather = weatherData
                    //self.error = nil
                    for locations in weatherData.records.locations {
                        for location in locations.location{
                            for weatherElement in location.weatherElement {
                                if weatherElement.elementName == "Wx" {
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "自定義 Wx 文字" {
                                                self.Wx.append(elementValue.value)
                                                self.labels7.append(forecastTime.startTime)
                                            }
                                            // Use startTime as the label for the x-axis
                                            //self.labels7.append(forecastTime.startTime)
                                        }
                                    }
                                }else if weatherElement.elementName == "MaxT"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "攝氏度"{
                                                self.MaxT.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }else if weatherElement.elementName == "MinT"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "攝氏度"{
                                                self.MinT.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }else if weatherElement.elementName == "PoP12h"{
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "百分比"{
                                                if elementValue.value == " "{
                                                    self.Pop12h.append("?")
                                                }else{
                                                    self.Pop12h.append(elementValue.value)
                                                }
                                            }
                                            // Use startTime as the label for the x-axis
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //print(self.forecastData.prefix(5))
                    print(self.labels7.prefix(5))
                    print(self.Pop12h.prefix(5))
                    print(self.Wx.prefix(5))
                    print(self.MaxT.prefix(5))
                }
            }catch {
                print("Error decoding data: \(error)")
                //self.error = error
            }
        }
        task.resume()
        
        var request2 = URLRequest(url: URL(string: "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-069?Authorization=CWB-C1B7677A-1F07-4D83-8DE0-A89EBF7C4258&format=JSON&locationId=F-D0047-071&locationName=%E6%B7%A1%E6%B0%B4%E5%8D%80&elementName=WeatherDescription")!,timeoutInterval: Double.infinity)
        request2.addValue("application/json", forHTTPHeaderField: "accept")
        request2.addValue("TS01a5ae52=0107dddfef9e7bce02505436a2c8d666308ada74dacd618e24ac0f4f14aab5814dc7131309872f99a4f9d0609c823e3ccc6f77852b", forHTTPHeaderField: "Cookie")

        request2.httpMethod = "GET"
        print("request")
        
        
        let task2 = URLSession.shared.dataTask(with: request2) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                print("fetch")
                let weatherData = try decoder.decode(SimpleEntry.Weather.self, from: data)
                
                DispatchQueue.main.async {
                    self.weather = weatherData
                    //self.error = nil
                    for locations in weatherData.records.locations {
                        for location in locations.location{
                            for weatherElement in location.weatherElement {
                                if weatherElement.elementName == "WeatherDescription" {
                                    for forecastTime in weatherElement.time {
                                        for elementValue in forecastTime.elementValue {
                                            // Extract temperature and probability of precipitation data
                                            if elementValue.measures == "NA" {
                                                self.forecastData.append(elementValue.value)
                                            }
                                            // Use startTime as the label for the x-axis
                                            self.labels.append(forecastTime.startTime)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    print(self.forecastData.prefix(5))
                    print("widget work !!!")
                }
            }catch {
                print("Error decoding data: \(error)")
                //self.error = error
            }
        }
        task2.resume()
    }
}


struct Provider: TimelineProvider {
    let networkManager = NetworkManager()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        networkManager.getCurrentData { data in
            let entry = SimpleEntry(date: Date())
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        networkManager.getCurrentData { data in
            let timeline = Timeline(
                entries: [SimpleEntry(date: Date())],
                policy: .after(
                    Calendar.current.date(byAdding: .minute, value: 30, to: Date())!
                )
            )
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
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
}

struct widgetEntryView : View {
    var entry: Provider.Entry
    var T: String
    var Wx: String
    var MaxT: String
    var MinT: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(T)")
                    .font(.system(size: 35))
                    
                Image(systemName: "cloud.drizzle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            
            VStack (alignment: .leading){
                Text("H: \(MaxT)  L: \(MinT)")
                Text("\(Wx)")
                Text("")
            }
            .font(.system(size: 10))
            .offset(x: 5,y:20)
        }
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetEntryView(
                entry: entry,
                T: "30",
                Wx: "hello",
                MaxT: "50",
                MinT: "0"
            )
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct tian_qi_widet_Previews: PreviewProvider {
    static var previews: some View {
        if let currentData = NetworkManager().forecastData.first?.split(separator: "。"){
            Group{
                widgetEntryView(
                    entry: SimpleEntry(date: Date()),
                    T: currentData[2].filter("0123456789.".contains) as String,
                    Wx: String(NetworkManager().Wx.first ?? "error"),
                    MaxT: String(NetworkManager().MaxT.first ?? "error") ,
                    MinT: String(NetworkManager().MinT.first ?? "error")
                )
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
            }
        }else{
            Group{
                widgetEntryView(
                    entry: SimpleEntry(date: Date()),
                    T: "error",
                    Wx: String(NetworkManager().Wx.first ?? "error"),
                    MaxT: String(NetworkManager().MaxT.first ?? "error") ,
                    MinT: String(NetworkManager().MinT.first ?? "error")
                )
                    .previewContext(WidgetPreviewContext(family: .systemSmall))
            }
        }
    }
}

//The application supports opening files, but doesn't declare whether it supports opening them in place. You can add an LSSupportsOpeningDocumentsInPlace entry or an UISupportsDocumentBrowser entry to your Info.plist to declare support.
