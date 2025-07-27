//
//  cathnowApp.swift
//  cathnow
//
//  Created by tom whittaker on 7/27/25.
//

import SwiftUI

@main
struct CathNowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
}
