//
//  Test.swift
//  tian qi
//
//  Created by bochain on 2023/7/20.
//

import SwiftUI

struct Test: View {

    @EnvironmentObject var FetchData : DataModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(FetchData.locations, id:\.self){ locations in
                    VStack {
                        Text("\(locations.locationName)")
                        ForEach(locations.weatherElement, id: \.elementName) { element in
                            if element.elementName == "Wx" {
                                if let wx = element.time.first?.parameter.parameterName {
                                    Text("\(wx)")
                                }
                            }
                            if element.elementName == "PoP" {
                                if let PoP = element.time.first?.parameter.parameterName{
                                    Text("降雨: \(PoP) %")
                                }
                            }
                            if element.elementName == "MaxT" {
                                if let temperature = element.time.first?.parameter.parameterName,
                                   let unit = element.time.first?.parameter.parameterUnit {
                                    Text("最高溫: \(temperature) \(unit)")
                                }
                            }
                            if element.elementName == "MinT" {
                                if let temperature = element.time.first?.parameter.parameterName,
                                   let unit = element.time.first?.parameter.parameterUnit {
                                    Text("最低溫: \(temperature) \(unit)")
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                    }
                }
            }
            .navigationTitle("天氣")
        }
        .onAppear {
            FetchData.fetch(now: "台北市")
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
            .environmentObject(DataModel())
    }
}
