//
//  HazardView.swift
//  tian qi
//
//  Created by bochain on 2023/7/28.
//

import SwiftUI

struct HazardView: View {
    var hazardlist: [HazardInfo] = []
    var body: some View {
        VStack {
            ForEach(hazardlist, id:\.info.phenomena) { info in
                HazardDetailView(info: info)
                    .padding()
            }
        }
    }
}


struct HazardDetailView: View {
    var info: HazardInfo
    var body: some View {
        //濃霧 大雨 豪雨 大豪雨 超大豪雨 陸上強風
        HStack(spacing: 15) {
            Image(systemName: getPic(from: info.info.phenomena))
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 10) {
                Text(info.info.phenomena)
                HStack{
                    Text(getTime(from: info.validTime.startTime))
                    Text("~")
                    Text(getTime(from: info.validTime.endTime))
                }
            }
        }
    }
    
    private func getPic(from text: String) -> String{
        var pic = "cloud.rain.circle.fill"
        switch text{
        case "濃霧":
            pic = "cloud.fog.circle.fill"
        case "大雨", "豪雨", "大豪雨", "超大豪雨":
            pic = "cloud.rain.circle.fill"
        case "陸上強風":
            pic = "wind.snow.circle.fill"
        default:
            pic = "cloud.rain.circle.fill"
        }
        return pic
    }
    
    private func getTime(from timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: timestamp) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "MM/dd HH:mm"
            return hourFormatter.string(from: date)
        }
        return ""
    }
}

struct HazardView_Previews: PreviewProvider {
    static var test_list: [HazardInfo] = [
        HazardInfo(info: tian_qi.HazardInfo.Info(language: "zh-TW", phenomena: "陸上強風", significance: "特報"), validTime: tian_qi.HazardInfo.ValidTime(startTime: "2023-07-28 13:34:00", endTime: "2023-07-28 23:00:00")),
        HazardInfo(info: tian_qi.HazardInfo.Info(language: "zh-TW", phenomena: "超大豪雨", significance: "特報"), validTime: tian_qi.HazardInfo.ValidTime(startTime: "2023-07-28 13:34:00", endTime: "2023-07-28 23:00:00"))
    ]
    static var previews: some View {
        HazardView(hazardlist: test_list)
    }
}
