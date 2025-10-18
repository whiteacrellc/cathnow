# Fix: Info.plist Copy and Process Command Conflict

## 🔴 Problem
Xcode has both a copy command AND a process command for the same Info.plist file. This means:
- The Info.plist is being treated as a bundle resource (copy command)
- The Info.plist is being treated as a target configuration file (process command)

## 🔧 Solution: Remove Info.plist from Bundle Resources

### Step 1: Check Bundle Resources Phase

**In Xcode:**

1. **Select your project** → **`nowcath` target**
2. **Go to "Build Phases" tab**
3. **Expand "Copy Bundle Resources" section**
4. **Look for `Info.plist` in the list**
5. **If found, select it and click the "-" button to remove it**

### Step 2: Verify Info.plist File Setting

1. **Stay in `nowcath` target**
2. **Go to "Build Settings" tab**
3. **Search for "Info.plist File"**
4. **Make sure it shows:** `nowcath/Info.plist`

### Step 3: Alternative Method - Remove and Use Target Settings

If the above doesn't work, you can remove the custom Info.plist and use Xcode's target settings instead:

1. **Right-click `nowcath/Info.plist` in Project Navigator**
2. **Choose "Delete" → "Move to Trash"**
3. **Select `nowcath` target → "Info" tab**
4. **Add Custom iOS Target Property:**
   - Key: `NSSupportsLiveActivities`
   - Type: Boolean
   - Value: YES

### Step 4: Clean and Build

1. **Product → Clean Build Folder**
2. **Product → Build**

## 🎯 Quick Fix (Most Likely Solution):

The Info.plist file is probably in "Copy Bundle Resources" when it should only be referenced in "Build Settings" → "Info.plist File".

**Remove it from Copy Bundle Resources and keep it only as the target's Info.plist file setting.**

## ✅ Expected Result:
- Only one process command for Info.plist
- Successful build
- Live Activities support enabled