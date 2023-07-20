//
//  Row.swift
//  tian qi
//
//  Created by bochain on 2023/7/20.
//

import SwiftUI

struct Row: View {
    //var data : Location
    
    var body: some View {
        Text("hello")
        //Text("data.locationName")
    }
}

struct Row_Previews: PreviewProvider {
    static var locations = DataModel().locations
    
    static var previews: some View {
        //Row(data: DataModel().locations[0])
        Row()
    }
}
