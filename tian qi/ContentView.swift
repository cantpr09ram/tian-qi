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
        TabView(selection: $selection) {
            CurrentView()
                .tabItem{
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            CurrentView()
                .tabItem{
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }.onAppear{
            fetchdata.fetch2Day()
            fetchdata.fetchHazard()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
