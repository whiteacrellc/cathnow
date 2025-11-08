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
                            .foregroundColor(.blue)
                        Text("Cath Rmdr")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Every \(context.attributes.intervalText)")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        Image(systemName: "timer")
                            .foregroundColor(.blue)
                        Text(context.state.nextAlarmTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .contentTransition(.numericText())
                            .monospacedDigit()
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    HStack {
                        Spacer()
                        Text("Next catheter reminder")
                            .font(.caption2)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                }
            } compactLeading: {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.blue)
            } compactTrailing: {
                Text(context.state.nextAlarmTime, style: .timer)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .contentTransition(.numericText())
                    .monospacedDigit()
            } minimal: {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.blue)
            }
            .widgetURL(URL(string: "cathrmdr://timer"))
            .keylineTint(.blue)
        }
    }

}

struct LockScreenLiveActivityView: View {
    let context: ActivityViewContext<CathRmdrActivityAttributes>

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "cross.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title3)
                Text("Cath Rmdr")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                Spacer()
                Text("Every \(context.attributes.intervalText)")
                    .font(.caption)
                    .foregroundColor(.blue)
            }

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Next reminder in:")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(context.state.nextAlarmTime, style: .timer)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .contentTransition(.numericText())
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Scheduled for:")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text(context.state.nextAlarmTime, style: .time)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
