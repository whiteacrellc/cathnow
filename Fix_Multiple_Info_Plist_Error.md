# Fix: Multiple commands produce Info.plist

## 🔴 Problem
Xcode is finding multiple Info.plist files or the same Info.plist is assigned to multiple targets.

## 🔧 Solution Steps

### Step 1: Check File Target Membership

**In Xcode Project Navigator:**

1. **Select `nowcath/Info.plist`**
   - File Inspector (right panel) → Target Membership
   - **ONLY `nowcath` should be checked** ✅
   - **`CathNowLiveActivity` should be UNCHECKED** ❌

2. **Select `CathNowLiveActivity/Info.plist`**
   - File Inspector (right panel) → Target Membership
   - **ONLY `CathNowLiveActivity` should be checked** ✅
   - **`nowcath` should be UNCHECKED** ❌

### Step 2: Alternative Fix - Remove and Re-add

If Step 1 doesn't work:

1. **Remove both Info.plist files from project** (right-click → Delete → Remove Reference)
2. **Clean Build Folder** (Product → Clean Build Folder)
3. **Re-add files correctly:**
   - Right-click `nowcath` folder → Add Files
   - Select `nowcath/Info.plist`
   - **Ensure ONLY `nowcath` target is checked**
   - Right-click `CathNowLiveActivity` folder → Add Files
   - Select `CathNowLiveActivity/Info.plist`
   - **Ensure ONLY `CathNowLiveActivity` target is checked**

### Step 3: Verify Target Settings

**Main App Target (`nowcath`):**
- Build Settings → Search "Info.plist File"
- Should be: `nowcath/Info.plist`

**Widget Extension Target (`CathNowLiveActivity`):**
- Build Settings → Search "Info.plist File"
- Should be: `CathNowLiveActivity/Info.plist`

### Step 4: Check for Duplicate Files

Sometimes Xcode creates duplicate references:

1. **Search for "Info.plist" in Project Navigator**
2. **Look for any duplicate entries**
3. **Delete duplicate references** (not the files themselves)

## 🚫 Common Mistakes

- ❌ Adding both Info.plist files to both targets
- ❌ Having duplicate file references in Project Navigator
- ❌ Not setting the correct Info.plist file path in Build Settings

## ✅ Correct Configuration

```
nowcath/Info.plist → ONLY nowcath target
CathNowLiveActivity/Info.plist → ONLY CathNowLiveActivity target
```

## 🔄 After Fixing

1. **Clean Build Folder**
2. **Delete Derived Data**
3. **Restart Xcode**
4. **Build both targets**

This should resolve the "Multiple commands produce" error.