//
//  tian_qiApp.swift
//  tian qi
//
//  Created by bochain on 2023/7/16.
//

import SwiftUI

@main
struct tian_qiApp: App {
    @StateObject private var dataModel = DataModel()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModel)
        }
    }
}
