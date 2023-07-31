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
    var Time: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WeekDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeekDetail(
            MaxT: "30",
            MinT: "20",
            Wx: "陰",
            Time: "2023-08-01 18:00:00"
        )
    }
}
