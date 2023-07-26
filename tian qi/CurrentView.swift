//
//  CurrentView.swift
//  tian qi
//
//  Created by bochain on 2023/7/26.
//

import SwiftUI

struct CurrentView: View {
    @StateObject var fetchdata = DataModel()
    var  weatherdescription : [String] = []
    var cityName:String = ""
    var townName:String = ""
    
    var body: some View {
        if fetchdata.weather != nil{
            VStack{
                Text(cityName)
                Text(weatherdescription[2].filter("0123456789.".contains))
                    .font(.system(size: 50))
                
            }
            .onAppear {
                fetchdata.fetch()
            }
        }else{
            Text("Loading...")
        }
        
    }
}

struct CurrentView_Previews: PreviewProvider {
    static var weatherdescription = ["多雲","降雨機率 10%","溫度攝氏28度","舒適","偏東風 平均風速3-4級(每秒6公尺)","相對濕度80%"]
    static var CityName = "新北市"
    static var TownName = "淡水區"
    static var previews: some View {
        CurrentView(
            weatherdescription: weatherdescription,
            cityName: CityName,
            townName: TownName
        )
    }
}


//keyNotFound(CodingKeys(stringValue: "datasetDescription", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"datasetDescription\", intValue: nil) (\"datasetDescription\"), converted to dataset_description.", underlyingError: nil))
