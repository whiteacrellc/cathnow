# How to Add Info.plist to Your Xcode Project

## ✅ Created: `nowcath/Info.plist` with NSSupportsLiveActivities = true

## Next Steps in Xcode:

### 1. Add Info.plist to Project
1. **Right-click** on the `nowcath` folder in Xcode Project Navigator
2. **Select "Add Files to 'nowcath'"**
3. **Navigate to and select** `nowcath/Info.plist`
4. **Make sure** "Add to target: nowcath" is checked
5. **Click "Add"**

### 2. Configure Target to Use Info.plist
1. **Select your project** at the top of Project Navigator
2. **Select the `nowcath` target**
3. **Go to "Build Settings" tab**
4. **Search for "Info.plist"**
5. **Set "Info.plist File" to:** `nowcath/Info.plist`

### 3. Alternative Method (if above doesn't work)
1. **Select the `nowcath` target**
2. **Go to "Info" tab**
3. **Manually add Custom iOS Target Property:**
   - **Key:** `NSSupportsLiveActivities`
   - **Type:** Boolean
   - **Value:** YES

## 📋 What's in the Info.plist:

```xml
<key>NSSupportsLiveActivities</key>
<true/>
```

Plus all the standard iOS app configuration keys including:
- Bundle identifiers
- Supported orientations
- Notification permissions
- Scene manifest for SwiftUI

## 🔄 After Adding:

1. **Clean Build Folder** (Product → Clean Build Folder)
2. **Build the project**
3. **Test Live Activities**

The `NSSupportsLiveActivities` setting will enable Live Activities for your app, which should resolve the bundle descriptor error you were seeing.