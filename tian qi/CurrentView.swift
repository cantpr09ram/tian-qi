//
//  CurrentView.swift
//  tian qi
//
//  Created by bochain on 2023/7/26.
//

import SwiftUI

struct CurrentView: View {
    @EnvironmentObject var fetchdata : DataModel
    @State private var showError = false
    @State private var error: Error?
    @State private var forecastData: [String] = []
    @State private var  labels: [String] = []
    @State var Offset: CGFloat = 0
    
    var cityName:String = ""
    var townName:String = ""
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .center, spacing: 5){
                VStack{
                    Text(townName)
                        .font(.system(size: 30))
                        .padding(.top, 20)
                    if let currentData = fetchdata.forecastData.first?.split(separator: "。"){
                        CurrentDetail(
                            temperature: currentData[2].filter("0123456789.".contains) as String,
                            Wx: String(currentData[0]),
                            MaxT: "33",
                            MinT: "20"
                        )
                    } else {
                        Text("Loading...")
                    }
                }
                
                if fetchdata.forecastData.count >= 5 && fetchdata.labels.count >= 5 {
                    CustomStackView{
                        Label{
                            Text("近兩日天氣(三小時)")
                        }icon: {
                            Image(systemName: "chart.bar.doc.horizontal.fill")
                        }
                    }contentView: {
                        CurrentForecast(
                            forecastData: Array(fetchdata.forecastData),
                            labels: Array(fetchdata.labels)
                        )
                    }
                } else {
                    //Text("Loading...")
                }
                
                if fetchdata.hazardList.count > 0{
                    CustomStackView{
                        Label{
                            Text("天氣警報")
                        }icon: {
                            Image(systemName: "sos.circle")
                        }
                    }contentView: {
                        HazardView(
                            hazardlist: Array(fetchdata.hazardList)
                        )
                    }
                }
            }
            //getting offset
            .overlay(
                //using geometry reader
                GeometryReader {proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    DispatchQueue.main.async {
                        self.Offset = minY
                    }
                return Color.clear
                    
                }
                
            )
        }
        .task {
            if fetchdata.forecastData.isEmpty {
                do {
                    try await fetchdata.fetch2Day(); fetchdata.fetchHazard()
                    
                }catch {
                    self.error = error
                    showError = true
                }
            }
        }
        .alert(error?.localizedDescription ?? "", isPresented: $showError, actions: {})
        }
}

struct CurrentView_Previews: PreviewProvider {
    //static var weatherdescription = ["多雲","降雨機率 10%","溫度攝氏28度","舒適","偏東風 平均風速3-4級(每秒6公尺)","相對濕度80%"]
    static var CityName = "新北市"
    static var TownName = "淡水區"
    static var previews: some View {
        CurrentView(
            cityName: CityName,
            townName: TownName
        )
        .environmentObject(DataModel())
    }
}

