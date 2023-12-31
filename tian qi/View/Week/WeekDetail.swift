//
//  WeekDetail.swift
//  tian qi
//
//  Created by bochain on 2023/7/31.
//

import SwiftUI

struct WeekDetail: View {
    var Pop: String
    var MaxT: String
    var minMaxT: String
    var maxMaxT: String
    var MinT: String
    var maxMinT: String
    var minMinT: String
    var Wx: String
    var StartTime: String
    //var EndTime: String
    
    var body: some View {
        HStack{
            if (getDay(from: StartTime).isEmpty){
                VStack {
                    Text("00")
                        .padding()
                    .font(.system(size: 20))
                    
                }
            }else{
                VStack {
                    Text(getDay(from: StartTime))
                        .padding()
                    .font(.system(size: 20))
                    
                    if(getHour(from: StartTime) == "06" || getHour(from: StartTime) == "12"){
                        Image(systemName: "sun.min")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }else{
                        Image(systemName: "moon.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            
            VStack {
                Image(systemName: Text2Pic(Wx: Wx))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text("\(Pop) %")
                    .font(.system(size: 15))
            }
            .offset(x:0,y: 7)
            HStack{
                Text(MinT)
                ProgressBar(
                    MaxT: Int(MaxT)!,
                    minMaxT: Int(minMaxT)!,
                    maxMaxT: Int(maxMaxT)!,
                    MinT: Int(MinT)!,
                    maxMinT: Int(maxMinT)!,
                    minMinT: Int(minMinT)!
                )
                Text(MaxT)
            }.offset(x:0,y:7)
        }
        .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 8))
        .background(getHour(from: StartTime) == "18" ? Color("Night"): Color("Day"))
        .cornerRadius(12)
            
    }
    
    private func getDay(from timestamp: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: timestamp) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "dd"
            return hourFormatter.string(from: date)
        }
        return ""
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
    
    private func Text2Pic(Wx: String) ->String{
        var pic = "xmark.icloud.fill"
        switch Wx {
        case"晴天", "晴":
            pic = "sun.min"
        case"晴時多雲","多雲時晴","多雲","多雲時陰","陰時多雲","陰天":
            pic = "cloud.fill"
        case"多雲陣雨",
            "多雲短暫雨",
            "多雲短暫陣雨",
            "午後短暫陣雨",
            "短暫陣雨",
            "多雲時晴短暫陣雨",
            "多雲時晴短暫雨",
            "晴時多雲短暫陣雨",
            "晴短暫陣雨",
            "短暫雨",
            "多雲時陰短暫雨",
            "多雲時陰短暫陣雨",
            "陰時多雲短暫雨",
            "陰時多雲短暫陣雨",
            "晴午後陰短暫雨",
            "晴午後陰短暫陣雨",
            "陰短暫雨",
            "陰短暫陣雨",
            "陰午後短暫陣雨",
            "多雲時陰有雨",
            "多雲時陰陣雨",
            "晴時多雲陣雨",
            "多雲時晴陣雨",
            "陰時多雲有雨",
            "陰時多雲有陣雨",
            "陰時多雲陣雨",
            "陰有雨",
            "陰有陣雨",
            "陰雨",
            "陰陣雨",
            "陣雨",
            "午後陣雨",
            "多雲午後局部雨",
            "多雲午後局部陣雨",
            "多雲午後局部短暫雨",
            "多雲午後局部短暫陣雨",
            "多雲午後陣雨",
            "多雲午後短暫雨",
            "多雲午後短暫陣雨",
            "多雲時陰午後短暫陣雨",
            "陰時多雲午後短暫陣雨",
            "多雲局部雨",
            "多雲局部陣雨",
            "多雲局部短暫雨",
            "多雲局部短暫陣雨",
            "多雲時陰局部雨",
            "多雲時陰局部陣雨",
            "多雲時陰局部短暫雨",
            "多雲時陰局部短暫陣雨",
            "晴午後陰局部雨",
            "晴午後陰局部陣雨",
            "晴午後陰局部短暫雨",
            "晴午後陰局部短暫陣雨",
            "陰局部雨",
            "陰局部陣雨",
            "陰局部短暫雨",
            "陰局部短暫陣雨",
            "陰時多雲局部雨",
            "陰時多雲局部陣雨",
            "陰時多雲局部短暫雨",
            "陰時多雲局部短暫陣雨":
            pic = "cloud.drizzle.fill"
        case "多雲時晴午後短暫陣雨",
            "晴午後多雲局部雨",
            "晴午後多雲局部陣雨",
            "晴午後多雲局部短暫雨",
            "晴午後多雲局部短暫陣雨",
            "晴午後多雲短暫雨",
            "晴午後多雲短暫陣雨",
            "晴午後局部雨",
            "晴午後局部陣雨",
            "晴午後局部短暫雨",
            "晴午後局部短暫陣雨",
            "晴午後陣雨",
            "晴午後短暫雨",
            "晴午後短暫陣雨",
            "晴時多雲午後短暫陣雨":
            pic = "cloud.sun.rain.fill"
        case"雨天",
            "有雨":
            pic = "cloud.rain.fill"
        case"多雲陣雨或雷雨",
            "多雲短暫陣雨或雷雨",
            "多雲短暫雷陣雨",
            "多雲雷陣雨",
            "短暫陣雨或雷雨後多雲",
            "短暫雷陣雨後多雲",
            "短暫陣雨或雷雨",
            "晴時多雲短暫陣雨或雷雨",
            "晴短暫陣雨或雷雨",
            "多雲時晴短暫陣雨或雷雨",
            "午後短暫雷陣雨",
            "多雲時陰陣雨或雷雨",
            "多雲時陰短暫陣雨或雷雨",
            "多雲時陰短暫雷陣雨",
            "多雲時陰雷陣雨",
            "晴陣雨或雷雨",
            "晴時多雲陣雨或雷雨",
            "多雲時晴陣雨或雷雨",
            "陰時多雲有雷陣雨",
            "陰時多雲陣雨或雷雨",
            "陰時多雲短暫陣雨或雷雨",
            "陰時多雲短暫雷陣雨",
            "陰時多雲雷陣雨",
            "陰有陣雨或雷雨",
            "陰有雷陣雨",
            "陰陣雨或雷雨",
            "陰雷陣雨",
            "晴午後陰短暫陣雨或雷雨",
            "晴午後陰短暫雷陣雨",
            "陰短暫陣雨或雷雨",
            "陰短暫雷陣雨",
            "雷雨",
            "陣雨或雷雨後多雲",
            "陰陣雨或雷雨後多雲",
            "陰短暫陣雨或雷雨後多雲",
            "陰短暫雷陣雨後多雲",
            "陰雷陣雨後多雲",
            "雷陣雨後多雲",
            "陣雨或雷雨",
            "雷陣雨",
            "午後雷陣雨",
            "多雲時晴雷陣雨",
            "多雲時晴午後短暫雷陣雨",
            "多雲時陰午後短暫雷陣雨",
            "陰時多雲午後短暫雷陣雨",
            "陰午後短暫雷陣雨":
            pic = "cloud.bolt.rain.fill"
        case"晴午後多雲陣雨或雷雨",
            "晴午後多雲雷陣雨",
            "晴午後陣雨或雷雨",
            "晴午後雷陣雨",
            "晴午後多雲局部陣雨或雷雨",
            "晴午後多雲局部短暫陣雨或雷雨",
            "晴午後多雲局部短暫雷陣雨",
            "晴午後多雲局部雷陣雨",
            "晴午後多雲短暫陣雨或雷雨",
            "晴午後多雲短暫雷陣雨",
            "晴午後局部短暫雷陣雨",
            "晴午後局部雷陣雨",
            "晴午後短暫雷陣雨",
            "晴雷陣雨 晴時多雲雷陣雨",
            "晴時多雲午後短暫雷陣雨",
            "多雲午後局部陣雨或雷雨",
            "多雲午後局部短暫陣雨或雷雨",
            "多雲午後局部短暫雷陣雨",
            "多雲午後局部雷陣雨",
            "多雲午後陣雨或雷雨",
            "多雲午後短暫陣雨或雷雨",
            "多雲午後短暫雷陣雨",
            "多雲午後雷陣雨"
            :
            pic = "cloud.sun.bolt.fill"
        case"多雲局部陣雨或雪",
            "多雲時陰有雨或雪",
            "多雲時陰短暫雨或雪",
            "多雲短暫雨或雪",
            "陰有雨或雪",
            "陰時多雲有雨或雪",
            "陰時多雲短暫雨或雪",
            "陰短暫雨或雪",
            "多雲時陰有雪",
            "多雲時陰短暫雪",
            "多雲短暫雪",
            "陰有雪",
            "陰時多雲有雪",
            "陰時多雲短暫雪",
            "陰短暫雪",
            "有雨或雪",
            "有雨或短暫雪",
            "陰有雨或短暫雪",
            "陰時多雲有雨或短暫雪",
            "多雲時陰有雨或短暫雪",
            "多雲有雨或短暫雪",
            "多雲有雨或雪",
            "多雲時晴有雨或雪",
            "晴時多雲有雨或雪",
            "晴有雨或雪",
            "短暫雨或雪",
            "多雲時晴短暫雨或雪",
            "晴時多雲短暫雨或雪",
            "晴短暫雨或雪",
            "有雪",
            "多雲有雪",
            "多雲時晴有雪",
            "晴時多雲有雪",
            "晴有雪",
            "短暫雪",
            "多雲時晴短暫雪",
            "晴時多雲短暫雪",
            "晴短暫雪",
            "下雪",
            "積冰",
            "暴風雪":
            pic = "cloud.snow.fill"
        case"晴有霧",
            "晴晨霧",
            "晴時多雲有霧",
            "晴時多雲晨霧",
            "多雲時晴有霧",
            "多雲時晴晨霧",
            "多雲有霧",
            "多雲晨霧",
            "有霧",
            "晨霧",
            "陰有霧",
            "陰晨霧",
            "多雲時陰有霧",
            "多雲時陰晨霧",
            "陰時多雲有霧",
            "陰時多雲晨霧":
            pic = "cloud.fog.fill"
        case"陰":
            pic = "wind"
        
        default:
            pic = "person.fill.questionmark"
            
        }
        return pic
    }
}

struct WeekDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeekDetail(
            Pop: "60",
            MaxT: "32",
            minMaxT: "30",
            maxMaxT: "35",
            MinT: "23",
            maxMinT: "29",
            minMinT: "23",
            Wx: "陰",
            StartTime: "2023-08-01 06:00:00"
            //EndTime: "2023-08-01 18:00:00"
        )
    }
}
