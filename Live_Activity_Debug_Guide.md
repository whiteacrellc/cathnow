# Live Activity Runtime Error Debug Guide

## 🔴 Current Error Analysis
"Failed to get descriptors for extensionBundleID" suggests the widget extension isn't properly registered with the system.

## 🔍 Debug Steps

### 1. Check Console Output
Run the app and check Xcode console for our new debug messages:
- Look for "🔄 Starting Live Activity..."
- Check iOS version and authorization status
- Note any error details

### 2. Verify Critical Files

**Check if `CathNowActivityAttributes.swift` is in BOTH targets:**
1. Select `CathNowActivityAttributes.swift` in Project Navigator
2. File Inspector → Target Membership
3. **BOTH `nowcath` AND `CathNowLiveActivity` must be checked** ✅

### 3. Bundle ID Verification

**Check bundle identifiers:**
1. **Main app target:** Should be `net.tomw.cathnow`
2. **Widget extension target:** Should be `net.tomw.cathnow.CathNowLiveActivity`

### 4. Build Both Targets

**Build targets separately:**
1. Select `CathNowLiveActivity` scheme → Build
2. Select `nowcath` scheme → Build
3. Both should build successfully

### 5. Device vs Simulator

**Test requirements:**
- Live Activities work differently in simulator
- For full testing, use **physical device** with iOS 16.1+
- Dynamic Island requires **iPhone 14 Pro or later**

### 6. App Settings

**Check device settings:**
1. **Settings → Face ID & Passcode → Allow Access When Locked → Today View and Search**
2. **Settings → Your App → Allow Live Activities** (appears after first launch)

## 🎯 Most Common Issues

### Issue 1: Missing Shared File
❌ `CathNowActivityAttributes.swift` not in both targets
✅ **Fix:** Add to both targets in File Inspector

### Issue 2: Bundle ID Mismatch
❌ Wrong bundle identifier format
✅ **Fix:** Widget should be `main.bundle.id.CathNowLiveActivity`

### Issue 3: Missing Live Activities Support
❌ No `NSSupportsLiveActivities` in main app
✅ **Fix:** Add in target settings (Custom iOS Target Properties)

### Issue 4: Simulator Limitations
❌ Testing only in simulator
✅ **Fix:** Test on physical device

## 🔧 Quick Verification Checklist

- [ ] Both targets build successfully
- [ ] `CathNowActivityAttributes.swift` in both targets
- [ ] Bundle IDs follow correct pattern
- [ ] `NSSupportsLiveActivities = YES` in main app
- [ ] Testing on physical device (iOS 16.1+)
- [ ] Console shows "✅ Live Activity started successfully!"

## 📱 Next Steps

1. **Run app with new debug logging**
2. **Check console output** for specific error details
3. **Verify bundle ID pattern** matches exactly
4. **Test on physical device** if using simulator

The enhanced logging will help identify exactly where the process is failing.