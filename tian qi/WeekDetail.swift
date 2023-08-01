//
//  WeekDetail.swift
//  tian qi
//
//  Created by bochain on 2023/7/31.
//

import SwiftUI

struct WeekDetail: View {
    var MaxT: String
    var MinT: String
    var Wx: String
    var StartTime: String
    var EndTime: String
    
    var body: some View {
        HStack{
            Text(Wx)
            HStack{
                Text(MaxT)
                Text(MinT)
            }
        }
    }
}

struct WeekDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeekDetail(
            MaxT: "30",
            MinT: "20",
            Wx: "陰",
            StartTime: "2023-08-01 06:00:00",
            EndTime: "2023-08-01 18:00:00"
        )
    }
}
