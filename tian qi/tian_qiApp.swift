//
//  tian_qiApp.swift
//  tian qi
//
//  Created by bochain on 2023/7/16.
//

import SwiftUI

@main
struct tian_qiApp: App {
    @StateObject private var FetchData = DataModel()
    @StateObject private var FetchLocation = ViewLocation()
    var body: some Scene {
        WindowGroup {
            MainView()
            //Test()
        }
    }
}
