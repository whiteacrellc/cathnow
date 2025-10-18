# Live Activity Setup Instructions

## Overview
I've added Live Activity support to display the catheter countdown in the Dynamic Island when the app is not in the foreground. Here's what was implemented and how to set it up in Xcode:

## Files Added/Modified

### New Files Created:
1. `CathNowLiveActivity/CathNowLiveActivityBundle.swift` - Widget bundle entry point
2. `CathNowLiveActivity/CathNowLiveActivity.swift` - Live Activity widget implementation
3. `CathNowLiveActivity/Info.plist` - Widget extension configuration
4. `nowcath/CathNowActivityAttributes.swift` - Shared activity attributes
5. `nowcath/LiveActivityManager.swift` - Live Activity management logic

### Modified Files:
1. `nowcath/ContentView.swift` - Integrated Live Activity start/update/end logic

## Xcode Project Setup Required

### 1. Add Widget Extension Target
- In Xcode, go to File → New → Target
- Choose "Widget Extension"
- Name it "CathNowLiveActivity"
- Ensure it includes Live Activities support
- Set minimum deployment target to iOS 16.1

### 2. Add Live Activities Support to Main App
- Select your main app target
- Go to Info tab
- Add "Supports Live Activities" (NSSupportsLiveActivities) = YES

### 3. Add Files to Correct Targets
- Add `CathNowActivityAttributes.swift` to both main app and widget targets
- Ensure widget extension files are in the widget target only
- Ensure main app files with Live Activity code are in main app target

### 4. Configure Bundle Identifier
- Widget extension bundle ID should be: `your.main.app.bundleid.CathNowLiveActivity`

## How It Works

### Dynamic Island Views:
- **Minimal**: Shows cross icon
- **Compact**: Shows cross icon and countdown time (HH:MM format)
- **Expanded**: Shows full countdown (HH:MM:SS), interval info, and next reminder time

### Lock Screen View:
- Shows app name, countdown timer, next scheduled time, and interval info

### Automatic Management:
- Starts when user sets an alarm
- Updates every time the countdown resets to next interval
- Ends when user cancels/changes alarm settings

## Features Implemented

1. **Real-time Countdown**: Shows time remaining until next catheter reminder
2. **Dynamic Island Integration**: Compact and expanded views
3. **Lock Screen Widget**: Full information display
4. **Automatic Updates**: Syncs with app's countdown logic
5. **iOS Version Compatibility**: Gracefully handles devices without Live Activity support

## Usage
Once properly configured in Xcode, the Live Activity will automatically start when users set an alarm and appear in the Dynamic Island and Lock Screen, showing the countdown until the next catheter reminder.