//
//  MainView.swift
//  tian qi
//
//  Created by bochain on 2023/7/19.
//

import SwiftUI

struct WeatherNow {
    var StartTime : String
    var endTime : String
    var wx : String
    var MinT : String
    var MaxT : String
    var Ci : String
}

struct MainView: View {
    @StateObject private var dataModel = DataModel()
    @State private var maxTemperature = "0"
    
    
    let now = "新北市"
    
    var body: some View {
        NavigationView {
            VStack {
                if let weather = dataModel.weather {
                    ForEach(weather.records.location, id: \.locationName) { location in
                        if location.locationName == now {
                            Text("\(location.locationName)")
                            let weatherdata = location
                            ForEach(weatherdata.weatherElement, id: \.elementName) { element in
                                if element.elementName == "Wx" {
                                    if let wx = element.time.first?.parameter.parameterName {
                                        Text(verbatim: "\(element.time.first!.startTime) ~ \(element.time.first!.endTime)")
                                            .font(.subheadline)
                                        Text("\(wx)")
                                    }
                                }
                                if element.elementName == "PoP" {
                                    if let PoP = element.time.first?.parameter.parameterName{
                                        Text("降雨: \(PoP) %")
                                    }
                                }
                                if element.elementName == "MinT" {
                                    if let temperature = element.time.first?.parameter.parameterName,
                                       let unit = element.time.first?.parameter.parameterUnit {
                                        Text("最低溫: \(temperature) \(unit)")
                                    }
                                }
                                if element.elementName == "MaxT" {
                                    if let temperature = element.time.first?.parameter.parameterName,
                                       let unit = element.time.first?.parameter.parameterUnit {
                                        Text("最高溫: \(temperature) \(unit)")
                                            .onAppear{
                                                self.maxTemperature = maxTemperature
                                            }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
        }
        .onAppear {
            dataModel.fetch()
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

/*
 WX:天氣狀況
 Pop:降雨
 MinT: 最低溫
 MaxT: 最高溫
 CI: 舒適度
 */
