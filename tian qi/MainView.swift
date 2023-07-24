//
//  MainView.swift
//  tian qi
//
//  Created by bochain on 2023/7/19.
//

import SwiftUI

struct MainView: View {
    @StateObject var locationManager = FetchLatitudeandLongitude()
    @StateObject var viewlocation = ViewLocation()
    @State var i: Int = 0
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                VStack {
                    Text("Your location: \(location.latitude), \(abs(location.longitude))")
                    //Text("\(viewlocation.City)")
                    //Text("\(viewlocation.name)")
                    Text("\(i)")
                    Button("button"){
                        self.i += 1
                    }
                    
                }
                    
            }
        }
        .onAppear{
            locationManager.requestLocation()
        }
        .onChange(of: locationManager.location) { newLocation in
            if let location = newLocation {
                print("a")
                viewlocation.fetchLocation(latitude: location.latitude, longitude: location.longitude)
                print("a")
                }
            }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


/*
 WX:天氣狀況
 Pop:降雨
 MinT: 最低溫
 MaxT: 最高溫
 CI: 舒適度
 */
