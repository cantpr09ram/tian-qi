//
//  Detail.swift
//  tian qi
//
//  Created by bochain on 2023/7/20.
//

import SwiftUI

struct Detail: View {
    var Wx: String
    var PoP: String
    var MaxT:String
    var MinT: String
    
    var body: some View {
      Text("hello world")
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail(Wx: "summy", PoP: "20", MaxT: "30", MinT: "20")
    }
}
