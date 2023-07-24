//
//  LocationTest.swift
//  tian qi
//
//  Created by bochain on 2023/7/24.
//

import SwiftUI

struct LocationTest: View {
    
    @StateObject var viewLocation = ViewLocation()
    @StateObject var fetchweather = DataModel()
    var body: some View {
        //Text(viewlocation.name)
        VStack {
            Text(fetchweather.test)
            //Text(viewLocation.name)
            VStack {
                Text("City: \(viewLocation.City)")
                Text("Town: \(viewLocation.Town)")
                Text("\(viewLocation.name)")
            }
            Button("Fetch Location") {
                // Perform the fetchLocation function on the viewLocation instance
                viewLocation.fetchLocation(latitude: 24.156250, longitude: 120.698659)
            }
        }
        .onAppear{
            viewLocation.fetchLocation(latitude: 24.156250, longitude: 120.698659)
        }
    }
}

struct LocationTest_Previews: PreviewProvider {
    static var previews: some View {
        LocationTest()
    }
}
