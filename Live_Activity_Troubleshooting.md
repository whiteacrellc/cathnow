# Live Activity Troubleshooting Guide

## Error: "Failed to get descriptors for extensionBundleID"

This error typically occurs due to Xcode project configuration issues. Here's how to fix it:

## Step 1: Verify Target Configuration

### In Xcode Project Navigator:

1. **Select your project** at the top
2. **Check targets**: You should see:
   - `nowcath` (main app)
   - `CathNowLiveActivity` (widget extension)

### Widget Extension Target Settings:
1. **Select `CathNowLiveActivity` target**
2. **General Tab:**
   - Bundle Identifier: Should be `net.tomw.cathnow.CathNowLiveActivity`
   - Deployment Target: iOS 16.1 or later
   - Supported Platforms: iOS

3. **Signing & Capabilities:**
   - Same team and provisioning profile as main app
   - No additional capabilities needed

## Step 2: File Target Membership

### Check these files are in the correct targets:

**Main App Target (nowcath):**
- ✅ `nowcath/CathNowActivityAttributes.swift`
- ✅ `nowcath/LiveActivityManager.swift`
- ✅ `nowcath/ContentView.swift`

**Widget Extension Target (CathNowLiveActivity):**
- ✅ `CathNowLiveActivity/CathNowLiveActivityBundle.swift`
- ✅ `CathNowLiveActivity/CathNowLiveActivity.swift`
- ✅ `CathNowLiveActivity/Info.plist`

**BOTH Targets:**
- ✅ `nowcath/CathNowActivityAttributes.swift` (MUST be in both!)

### How to check/fix file membership:
1. Select file in Project Navigator
2. Open File Inspector (right panel)
3. In "Target Membership" section, check appropriate boxes

## Step 3: Clean and Rebuild

1. **Product → Clean Build Folder** (Cmd+Shift+K)
2. **Delete derived data:**
   - Xcode → Settings → Locations → Derived Data → Arrow icon
   - Delete the project folder
3. **Restart Xcode**
4. **Build both targets:**
   - Select main app scheme, build
   - Select widget extension scheme, build

## Step 4: Device Requirements

### Live Activities require:
- ✅ **iOS 16.1 or later**
- ✅ **Physical device** (not simulator for full testing)
- ✅ **iPhone 14 Pro or later** for Dynamic Island (optional, works on lock screen for all devices)

## Step 5: App Settings

### In your iPhone Settings:
1. **Settings → Face ID & Passcode → Lock Screen**
2. Make sure widgets are enabled
3. **Settings → Your App → Allow Live Activities** (appears after first run)

## Step 6: Code Verification

Make sure this code is in your main app's `Info.plist` or target settings:
```xml
<key>NSSupportsLiveActivities</key>
<true/>
```

## Step 7: Common Issues

### Bundle ID Mismatch:
- Main app: `net.tomw.cathnow`
- Widget: `net.tomw.cathnow.CathNowLiveActivity`

### Missing Files:
- Verify all Live Activity files exist and are added to correct targets

### Simulator Limitations:
- Live Activities work differently in simulator
- Test on physical device for full functionality

## Final Debug Steps:

1. **Check console logs** for ActivityKit errors
2. **Verify Live Activities are enabled** in device settings
3. **Test with simple Live Activity** first
4. **Make sure app has notification permissions**

If the error persists, the issue is likely in the Xcode project configuration rather than the code itself.