//
//  CurrentDetail.swift
//  tian qi
//
//  Created by bochain on 2023/7/26.
//

import SwiftUI

struct CurrentDetail: View {
    var temperature: String
    var Wx:String
    var MaxT: String
    var MinT: String
    
    var body: some View {
        VStack{
            Text("\(temperature)")
                .font(.system(size: 150))
            Text(Wx)
            HStack{
                Text("H: \(MaxT)°")
                Text("L: \(MinT)°")
            }
        }
    }
}

struct CurrentDetail_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDetail(
            temperature: "30",
            Wx: "多雲",
            MaxT: "33",
            MinT: "20"
        )
    }
}
