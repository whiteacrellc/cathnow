# Quick Fix: Multiple Info.plist Commands Error

## 🎯 Immediate Steps to Fix:

### 1. Check Target Membership (Most Common Fix)

**In Xcode:**

1. **Select `nowcath/Info.plist` in Project Navigator**
2. **File Inspector (right panel) → Target Membership section**
3. **Ensure ONLY `nowcath` is checked** ✅
4. **Uncheck `CathNowLiveActivity` if it's checked** ❌

5. **Select `CathNowLiveActivity/Info.plist` in Project Navigator**
6. **File Inspector (right panel) → Target Membership section**
7. **Ensure ONLY `CathNowLiveActivity` is checked** ✅
8. **Uncheck `nowcath` if it's checked** ❌

### 2. Clean and Build
1. **Product → Clean Build Folder** (⌘⇧K)
2. **Product → Build** (⌘B)

## 🔍 What Likely Happened:
When you added the Info.plist files to Xcode, they may have been accidentally added to both targets instead of just their respective target.

## ✅ Expected Result:
- `nowcath/Info.plist` → Only in `nowcath` target
- `CathNowLiveActivity/Info.plist` → Only in `CathNowLiveActivity` target

This should resolve the build error immediately.