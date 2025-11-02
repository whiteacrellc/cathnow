//
//  CathNowLiveActivity.swift
//  CathNowLiveActivity
//
//  Created by tom whittaker on 10/18/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CathRmdrLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CathRmdrActivityAttributes.self) { context in
            // Lock screen/banner UI goes here
            LockScreenLiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here. Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Image(systemName: "cross.circle.fill")
                            .foregroundColor(.yellow)
                        Text("Cath Rmdr")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.yellow)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Every \(context.attributes.intervalText)")
                        .font(.caption2)
                        .foregroundColor(.yellow)
                }
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(.yellow)
                        Text(expandedTimeText(from: context.state.nextAlarmTime))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.yellow)
                            .contentTransition(.numericText())
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Spacer()
                        Text("Next catheter reminder")
                            .font(.caption2)
                            .foregroundColor(.yellow)
                        Spacer()
                    }
                }
            } compactLeading: {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.yellow)
            } compactTrailing: {
                Text(compactTimeText(from: context.state.nextAlarmTime))
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                    .contentTransition(.numericText())
            } minimal: {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.yellow)
            }
            .widgetURL(URL(string: "cathrmdr://timer"))
            .keylineTint(.yellow)
        }
    }

    private func timeRemainingText(from nextAlarmTime: Date) -> String {
        let timeRemaining = nextAlarmTime.timeIntervalSince(Date())
        guard timeRemaining > 0 else { return "00:00:00" }

        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

    private func compactTimeText(from nextAlarmTime: Date) -> String {
        let timeRemaining = nextAlarmTime.timeIntervalSince(Date())
        guard timeRemaining > 0 else { return "00:00" }

        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60

        return String(format: "%02d:%02d", hours, minutes)
    }

    private func expandedTimeText(from nextAlarmTime: Date) -> String {
        let timeRemaining = nextAlarmTime.timeIntervalSince(Date())
        guard timeRemaining > 0 else { return "00:00" }

        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60

        return String(format: "%02d:%02d", hours, minutes)
    }
}

struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<CathRmdrActivityAttributes>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.yellow)
                    .font(.title3)
                Text("Cath Rmdr")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                Spacer()
                Text("Every \(context.attributes.intervalText)")
                    .font(.caption)
                    .foregroundColor(.yellow)
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Next reminder in:")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text(context.state.nextAlarmTime, style: .timer)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                        .contentTransition(.numericText())
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Scheduled for:")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text(context.state.nextAlarmTime, style: .time)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    private func timeRemainingText(from nextAlarmTime: Date) -> String {
        let timeRemaining = nextAlarmTime.timeIntervalSince(Date())
        guard timeRemaining > 0 else { return "00:00:00" }

        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
