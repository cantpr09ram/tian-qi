//
//  Detail.swift
//  tian qi
//
//  Created by bochain on 2023/7/20.
//

import SwiftUI

struct Detail: View {
    @StateObject private var dataModel = DataModel()
    var locationName : String
    
    var body: some View {
        if let currentweather = dataModel.currentweather {
            HStack {
                VStack {
                    Text(verbatim:"\(String(describing: currentweather.locationName))")
                        .font(.title)
                    Text(verbatim:"\(String(describing: currentweather.Wx))")
                        .font(.subheadline)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
                VStack {
                    Text(verbatim:"H:\(String(describing: currentweather.MaxT)) L:\(String(describing: currentweather.MinT))")
                }
            }
            .onAppear{
                dataModel.fetchLocation(locationName: locationName)
            }
        }else{
            Text("Loading...")
            Text(verbatim:"\(String(describing: dataModel.currentweather?.locationName))")
        }
    }
}

struct Detail_Previews: PreviewProvider {
    static var name = "新北市"
    static var previews: some View {
        Detail(locationName: name)
    }
}
