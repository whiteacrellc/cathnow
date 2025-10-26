import ActivityKit
import Foundation

struct CathRmdrActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var nextAlarmTime: Date
        var intervalText: String
        var isActive: Bool
    }

    // Fixed attributes that don't change during the Live Activity
    var intervalDuration: TimeInterval
    var intervalText: String
    var createdAt: Date
}