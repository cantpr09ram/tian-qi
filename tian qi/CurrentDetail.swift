//
//  CurrentDetail.swift
//  tian qi
//
//  Created by bochain on 2023/7/26.
//

import SwiftUI

struct CurrentDetail: View {
    var temperature: Int
    var Wx:String
    var location: String
    var MaxT: Int
    var MinT: Int
    
    var body: some View {
        VStack{
            Text(location)
            Text("\(temperature)")
                .font(.system(size: 90))
            Text(Wx)
            HStack{
                Text("H: \(MaxT)")
                Text("L: \(MinT)")
            }
        }
    }
}

struct CurrentDetail_Previews: PreviewProvider {
    static var previews: some View {
        CurrentDetail(
            temperature: 30,
            Wx: "多雲",
            location:"淡水",
            MaxT: 33,
            MinT: 20
        )
    }
}
