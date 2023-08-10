//
//  ContentView.swift
//  tian qi
//
//  Created by bochain on 2023/7/16.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    @EnvironmentObject var fetchdata : DataModel
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        CurrentView(cityName: "新北市", townName: "淡水區")
        //.onAppear{
          //  fetchdata.fetch2Day()
            //fetchdata.fetchHazard()
        //}
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
