//
//  weekView.swift
//  tian qi
//
//  Created by bochain on 2023/7/31.
//

import SwiftUI



struct weekView: View {
    struct ForecastItem: Identifiable {
        let id = UUID()
        let wx: String
        let label: String
        let maxT: Int
        let minT: Int
        let pop: String
    }

    var MaxTlist: [String]
    var MinTlist: [String]
    var labels: [String]
    var Wx: [String]
    var Pop: [String]
    
    var forecastItems: [ForecastItem] {
            Array(zip(Pop, zip(zip(Wx, labels), zip(MaxTlist.map { Int($0) ?? 0 }, MinTlist.map { Int($0) ?? 0 })))).map { tuple in
                let (pop, ((wx, label), (maxT, minT))) = tuple
                return ForecastItem(wx: wx, label: label, maxT: maxT, minT: minT, pop: pop)
            }
        }
    
        //let Maxmin: Int = self.MaxTlist.compactMap { Int($0) }.max() ?? 0
    
    var body: some View {
        let Maxmax: Int = MaxTlist.compactMap { Int($0) }.max() ?? 0
        let Maxmin: Int = MaxTlist.compactMap { Int($0) }.min() ?? 0
        let Minmax: Int = MinTlist.compactMap { Int($0) }.max() ?? 0
        let Minmin: Int = MinTlist.compactMap { Int($0) }.min() ?? 0
        
        ScrollView(.vertical) {
            VStack{
                ForEach(forecastItems) { item in
                    // Use item.forecast, item.label, item.maxT, item.minT here

                    WeekDetail(
                        Pop: String(item.pop),
                        MaxT: String(item.maxT),
                        minMaxT: String(Minmax),
                        maxMaxT: String(Maxmax),
                        MinT: String(item.minT),
                        maxMinT: String(Maxmin),
                        minMinT: String(Minmin),
                        Wx: String(item.wx),
                        StartTime: item.label
                        //EndTime: "2023-08-01 18:00:00"
                    )
                }
            }
        }
        /*
        ScrollView {
            VStack{
                WeekDetail(
         Wx: String(forecast[0]),
         PoP: String(forecast[1].filter("0123456789.".contains)),
                    Pop: "60",
                    MaxT: "31",
                    minMaxT: "30",
                    maxMaxT: "35",
                    MinT: "23",
                    maxMinT: "29",
                    minMinT: "23",
                    Wx: "陰",
                    StartTime: "2023-08-01 06:00:00"
                    //EndTime: "2023-08-01 18:00:00"
                )
                .padding(20)
                
                WeekDetail(
                    Pop: "62",
                    MaxT: "34",
                    minMaxT: "30",
                    maxMaxT: "35",
                    MinT: "25",
                    maxMinT: "29",
                    minMinT: "23",
                    Wx: "陰",
                    StartTime: "2023-08-01 06:00:00"
                    //EndTime: "2023-08-01 18:00:00"
                )
                .padding(20)
               
            }
        }*/
    }
}

struct weekView_Previews: PreviewProvider {
    static var forecastdata = [
        "短暫陣雨",
        "陰",
        "陰",
        "陰",
        "陰",
        "陰",
        "陰",
        "陰",
        "短暫陣雨",
        "短暫陣雨",
        "短暫陣雨"
    ]
    static var labels = [
        "2023-07-27 6:00:00",
        "2023-07-27 18:00:00",
        "2023-07-28 16:00:00",
        "2023-07-28 28:00:00",
        "2023-07-27 18:00:00",
        "2023-07-28 16:00:00",
        "2023-07-28 28:00:00",
        "2023-07-27 18:00:00",
        "2023-07-28 16:00:00",
        "2023-07-28 28:00:00",
        "2023-07-29 06:00:00"]
    static var MaxT = [
        "30",
        "31",
        "30",
        "30",
        "31",
        "30",
        "35",
        "30",
        "31",
        "30",
        "30"
    ]
    static var MinT = [
        "26",
        "26",
        "28",
        "28",
        "26",
        "28",
        "26",
        "28",
        "29",
        "29",
        "29"
    ]
    static var Pop = [
        "26",
        "26",
        "28",
        "28",
        "26",
        "28",
        "26",
        "28",
        "29",
        "29",
        "29"
    ]
    static var previews: some View {
        weekView(
            MaxTlist: MaxT,
            MinTlist: MinT,
            labels: labels,
            Wx: forecastdata,
            Pop: Pop
        )
    }
}
