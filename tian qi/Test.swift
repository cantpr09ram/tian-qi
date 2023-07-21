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
            /*
            List {
                ForEach(FetchData.locations, id:\.self){ locations in
                    VStack {
                        Text("\(locations.locationName)")
                    }
                }
             */
            Text("hello")
            }
            .navigationTitle("天氣")
            /*
            .onAppear {
                FetchData.fetch()
            }
             */
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
            .environmentObject(DataModel())
    }
}
