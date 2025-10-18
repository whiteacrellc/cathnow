# Xcode Configuration Checklist for Live Activities

## ❌ Current Error Fix Checklist

The error you're seeing suggests the widget extension is not properly configured. Follow these steps **exactly**:

### 1. Project Structure Verification ✅
- [x] `CathNowLiveActivity` folder exists
- [x] Widget extension target created
- [x] Files properly organized

### 2. Target Configuration (CRITICAL) ⚠️

#### Main App Target (`nowcath`):
1. **Select project → nowcath target → Info tab**
2. **Add Custom iOS Target Properties:**
   - Key: `NSSupportsLiveActivities`
   - Type: Boolean
   - Value: YES

#### Widget Extension Target (`CathNowLiveActivity`):
1. **General Tab:**
   - Bundle Identifier: `net.tomw.cathnow.CathNowLiveActivity`
   - Deployment Target: iOS 16.1
   - Supported Platform: iOS

2. **Build Settings Tab:**
   - Search for "Bundle Identifier"
   - Verify: `net.tomw.cathnow.CathNowLiveActivity`

### 3. File Target Membership (CRITICAL) ⚠️

**Check each file's target membership:**

#### Main App Target ONLY:
- ☑️ `nowcath/LiveActivityManager.swift`
- ☑️ `nowcath/ContentView.swift`

#### Widget Extension Target ONLY:
- ☑️ `CathNowLiveActivity/CathNowLiveActivityBundle.swift`
- ☑️ `CathNowLiveActivity/CathNowLiveActivity.swift`
- ☑️ `CathNowLiveActivity/Info.plist`

#### BOTH Targets (MUST BE CHECKED FOR BOTH):
- ☑️ `nowcath/CathNowActivityAttributes.swift` ← **CRITICAL!**

**How to verify:**
1. Select `CathNowActivityAttributes.swift`
2. File Inspector (right panel)
3. "Target Membership" section
4. **Both `nowcath` AND `CathNowLiveActivity` must be checked**

### 4. Build and Clean ⚠️

1. **Product → Clean Build Folder** (⌘⇧K)
2. **Delete Derived Data:**
   - Xcode → Settings → Locations → Derived Data
   - Click arrow next to path
   - Delete your project's folder
3. **Restart Xcode completely**
4. **Build widget extension target first:**
   - Select `CathNowLiveActivity` scheme
   - Product → Build (⌘B)
5. **Then build main app:**
   - Select `nowcath` scheme
   - Product → Build (⌘B)

### 5. Device Testing Requirements ⚠️

- **Physical iOS device** (iOS 16.1+)
- **Enable Live Activities** in device Settings
- **iPhone 14 Pro+** for Dynamic Island (optional)

### 6. Common Configuration Errors

❌ **Bundle ID mismatch**
❌ **CathNowActivityAttributes.swift not in both targets**
❌ **NSSupportsLiveActivities not set to YES**
❌ **Wrong deployment target (must be 16.1+)**
❌ **Missing widget extension scheme**

### 7. Verification Steps

After configuration:
1. Build should succeed for both targets
2. No "Failed to get descriptors" error
3. Console shows "Live Activities are enabled, attempting to start activity..."
4. Live Activity appears in Dynamic Island when app backgrounded

### 8. If Error Persists

1. **Delete widget extension target completely**
2. **Re-add Widget Extension target** (File → New → Target)
3. **Choose "Widget Extension"**
4. **Enable "Include Live Activity"**
5. **Replace generated files with our custom files**

The key issue is likely that `CathNowActivityAttributes.swift` is not added to both targets or the main app doesn't have Live Activities enabled in target settings.