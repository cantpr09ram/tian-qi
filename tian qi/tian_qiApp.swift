//
//  tian_qiApp.swift
//  tian qi
//
//  Created by bochain on 2023/7/16.
//

import SwiftUI

@main
struct tian_qiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
