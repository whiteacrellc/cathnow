import ActivityKit
import Foundation
import UIKit

class LiveActivityManager: ObservableObject {
    static let shared = LiveActivityManager()

    @Published var currentActivity: Any?

    private init() {}

    func startLiveActivity(intervalText: String, intervalSeconds: TimeInterval, nextAlarmTime: Date) {
        guard #available(iOS 16.1, *) else {
            print("❌ iOS 16.1+ required for Live Activities")
            return
        }

        print("🔄 Starting Live Activity...")
        print("📱 iOS Version: \(UIDevice.current.systemVersion)")

        // End any existing activity first
        endLiveActivity()

        let authInfo = ActivityAuthorizationInfo()
        print("🔐 Activity Authorization Status:")
        print("   - Activities Enabled: \(authInfo.areActivitiesEnabled)")
        print("   - Frequent Pushes: \(authInfo.frequentPushesEnabled)")

        guard authInfo.areActivitiesEnabled else {
            print("❌ Live Activities are not enabled. Check device settings.")
            return
        }

        print("✅ Live Activities are enabled, attempting to start activity...")
        print("⏰ Next alarm time: \(nextAlarmTime)")
        print("🔄 Interval: \(intervalText) (\(intervalSeconds) seconds)")

        let attributes = CathRmdrActivityAttributes(
            intervalDuration: intervalSeconds,
            intervalText: intervalText,
            createdAt: Date()
        )

        let contentState = CathRmdrActivityAttributes.ContentState(
            nextAlarmTime: nextAlarmTime,
            intervalText: intervalText,
            isActive: true
        )

        do {
            print("🚀 Requesting Live Activity...")
            let activity = try Activity<CathRmdrActivityAttributes>.request(
                attributes: attributes,
                contentState: contentState,
                pushType: nil
            )

            self.currentActivity = activity
            print("✅ Live Activity started successfully!")
            print("🆔 Activity ID: \(activity.id)")
            print("📊 Activity State: \(activity.activityState)")
        } catch {
            print("❌ Failed to start Live Activity: \(error)")
            print("🔍 Error details: \(error.localizedDescription)")
            print("📋 Error type: \(type(of: error))")
        }
    }

    func updateLiveActivity(nextAlarmTime: Date, intervalText: String) {
        guard #available(iOS 16.1, *),
              let activity = currentActivity as? Activity<CathRmdrActivityAttributes> else {
            return
        }

        let updatedContentState = CathRmdrActivityAttributes.ContentState(
            nextAlarmTime: nextAlarmTime,
            intervalText: intervalText,
            isActive: true
        )

        Task {
            await activity.update(using: updatedContentState)
        }
    }

    func endLiveActivity() {
        guard #available(iOS 16.1, *),
              let activity = currentActivity as? Activity<CathRmdrActivityAttributes> else {
            currentActivity = nil
            return
        }

        let finalContentState = CathRmdrActivityAttributes.ContentState(
            nextAlarmTime: Date(),
            intervalText: "",
            isActive: false
        )

        Task {
            await activity.end(using: finalContentState, dismissalPolicy: .immediate)
            DispatchQueue.main.async {
                self.currentActivity = nil
            }
        }
    }

    var isLiveActivityActive: Bool {
        return currentActivity != nil
    }
}