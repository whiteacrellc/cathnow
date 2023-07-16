//
//  cathnowApp.swift
//  cathnow
//
//  Created by tom whittaker on 7/27/25.
//

import SwiftUI

@main
struct cathnowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
