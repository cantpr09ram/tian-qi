//
//  CurrentForecast.swift
//  tian qi
//
//  Created by bochain on 2023/7/27.
//

import SwiftUI

struct CurrentForecast: View {
    var forecastData: [String]
    var labels: [String]
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(Array(zip(forecastData, labels)), id: \.0) { (value1, value2) in
                    let forecast = value1.split(separator: "。")
                    let time = getHour(from: value2)
                    ForecastDetail(
                        temperature: String(forecast[2].filter("0123456789.".contains)),
                        Wx: String(forecast[0]),
                        PoP: String(forecast[1].filter("0123456789.".contains)),
                        Time: String(time)
                    ).padding()
                }
            }
        }
    }
    private func getHour(from timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: timestamp) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "HH"
            return hourFormatter.string(from: date)
        }
        return ""
    }
}

struct CurrentForecast_Previews: PreviewProvider {
    static var forecastdata = [
        "短暫陣雨。降雨機率 50%。溫度攝氏32度。悶熱。東南風 平均風速>= 6級(每秒14公尺)。相對濕度75%。",
        "陰。降雨機率 50%。溫度攝氏32度。悶熱。東南風 平均風速>= 6級(每秒15公尺)。相對濕度77%。",
        "陰。降雨機率 20%。溫度攝氏30度。悶熱。東南風 平均風速>= 6級(每秒16公尺)。相對濕度78%。",
        "陰。降雨機率 20%。溫度攝氏29度。悶熱。東南風 平均風速>= 6級(每秒16公尺)。相對濕度75%。",
        "短暫陣雨。降雨機率 70%。溫度攝氏29度。舒適。東南風 平均風速>= 6級(每秒13公尺)。相對濕度70%。"]
    static var labels = [
        "2023-07-27 12:00:00",
        "2023-07-27 15:00:00",
        "2023-07-27 18:00:00",
        "2023-07-27 21:00:00",
        "2023-07-28 00:00:00"]
    static var previews: some View {
        CurrentForecast(
            forecastData: forecastdata,
            labels: labels
        )
    }
}
