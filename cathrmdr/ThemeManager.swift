/*
 * Copyright (c) 2025 White Acre Software LLC
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of White Acre Software LLC. You shall not disclose such
 * Confidential Information and shall use it only in accordance
 * with the terms of the license agreement you entered into with
 * White Acre Software LLC.
 *
 * Year: 2025
 */
import SwiftUI

// MARK: - Theme Manager
@MainActor
class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .dark

    enum AppTheme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
        case auto = "Auto"

        var displayName: String {
            return self.rawValue
        }
    }

    init() {
        // Load saved theme preference
        if let savedTheme = UserDefaults.standard.string(forKey: "AppTheme"),
           let theme = AppTheme(rawValue: savedTheme) {
            self.currentTheme = theme
        }
    }

    func setTheme(_ theme: AppTheme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "AppTheme")
    }

    var isDarkMode: Bool {
        switch currentTheme {
        case .dark:
            return true
        case .light:
            return false
        case .auto:
            // Follow system appearance - get from active window scene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                return window.traitCollection.userInterfaceStyle == .dark
            }
            // Fallback to UITraitCollection.current if window not available
            return UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
}

// MARK: - Dynamic Color System
extension Color {
    // MARK: - Primary Colors (Material Theme)
    static func dynamicPrimary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.506, green: 0.827, blue: 0.871) :     // #81D3DE - Material dark primary
            Color(red: 0.0, green: 0.412, blue: 0.447)         // #006972 - Material light primary
    }

    static func dynamicOnPrimary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.212, blue: 0.235) :       // #00363C - Material dark onPrimary
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - Material light onPrimary
    }

    static func dynamicPrimaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.310, blue: 0.337) :       // #004F56 - Material dark primaryContainer
            Color(red: 0.616, green: 0.941, blue: 0.984)       // #9DF0FB - Material light primaryContainer
    }

    static func dynamicOnPrimaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.616, green: 0.941, blue: 0.984) :     // #9DF0FB - Material dark onPrimaryContainer
            Color(red: 0.0, green: 0.310, blue: 0.337)         // #004F56 - Material light onPrimaryContainer
    }

    // MARK: - Secondary Colors (Material Theme)
    static func dynamicSecondary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.694, green: 0.796, blue: 0.812) :     // #B1CBCF - Material dark secondary
            Color(red: 0.290, green: 0.388, blue: 0.400)       // #4A6366 - Material light secondary
    }

    static func dynamicOnSecondary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.110, green: 0.204, blue: 0.216) :     // #1C3437 - Material dark onSecondary
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - Material light onSecondary
    }

    static func dynamicSecondaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.196, green: 0.294, blue: 0.310) :     // #324B4E - Material dark secondaryContainer
            Color(red: 0.804, green: 0.906, blue: 0.922)       // #CDE7EB - Material light secondaryContainer
    }

    static func dynamicOnSecondaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.804, green: 0.906, blue: 0.922) :     // #CDE7EB - Material dark onSecondaryContainer
            Color(red: 0.196, green: 0.294, blue: 0.310)       // #324B4E - Material light onSecondaryContainer
    }

    // MARK: - Tertiary Colors (Material Theme)
    static func dynamicTertiary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.725, green: 0.776, blue: 0.918) :     // #B9C6EA - Material dark tertiary
            Color(red: 0.318, green: 0.369, blue: 0.490)       // #515E7D - Material light tertiary
    }

    static func dynamicOnTertiary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.137, green: 0.188, blue: 0.302) :     // #23304D - Material dark onTertiary
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - Material light onTertiary
    }

    static func dynamicTertiaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.224, green: 0.275, blue: 0.392) :     // #394664 - Material dark tertiaryContainer
            Color(red: 0.851, green: 0.886, blue: 1.0)         // #D9E2FF - Material light tertiaryContainer
    }

    static func dynamicOnTertiaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.851, green: 0.886, blue: 1.0) :       // #D9E2FF - Material dark onTertiaryContainer
            Color(red: 0.224, green: 0.275, blue: 0.392)       // #394664 - Material light onTertiaryContainer
    }

    // MARK: - Error Colors (Material Theme)
    static func dynamicError(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 1.0, green: 0.706, blue: 0.671) :       // #FFB4AB - Material dark error
            Color(red: 0.729, green: 0.102, blue: 0.102)       // #BA1A1A - Material light error
    }

    static func dynamicOnError(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.412, green: 0.0, blue: 0.020) :       // #690005 - Material dark onError
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - Material light onError
    }

    static func dynamicErrorContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.576, green: 0.0, blue: 0.039) :       // #93000A - Material dark errorContainer
            Color(red: 1.0, green: 0.855, blue: 0.839)         // #FFDAD6 - Material light errorContainer
    }

    static func dynamicOnErrorContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 1.0, green: 0.855, blue: 0.839) :       // #FFDAD6 - Material dark onErrorContainer
            Color(red: 0.576, green: 0.0, blue: 0.039)         // #93000A - Material light onErrorContainer
    }

    // MARK: - Success Colors (Material Theme Compatible)
    static func dynamicSuccess(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.694, green: 0.796, blue: 0.812) :     // #B1CBCF - Using secondary for success in dark
            Color(red: 0.0, green: 0.412, blue: 0.447)         // #006972 - Using primary for success in light
    }

    static func dynamicOnSuccess(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.110, green: 0.204, blue: 0.216) :     // #1C3437 - Material theme compatible
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - White text
    }

    static func dynamicSuccessContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.196, green: 0.294, blue: 0.310) :     // #324B4E - Material theme compatible
            Color(red: 0.804, green: 0.906, blue: 0.922)       // #CDE7EB - Material theme compatible
    }

    // MARK: - Warning Colors (Material Theme Compatible)
    static func dynamicWarning(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.725, green: 0.776, blue: 0.918) :     // #B9C6EA - Using tertiary for warning in dark
            Color(red: 0.318, green: 0.369, blue: 0.490)       // #515E7D - Using tertiary for warning in light
    }

    static func dynamicOnWarning(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.137, green: 0.188, blue: 0.302) :     // #23304D - Material theme compatible
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - White text
    }

    static func dynamicWarningContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.224, green: 0.275, blue: 0.392) :     // #394664 - Material theme compatible
            Color(red: 0.851, green: 0.886, blue: 1.0)         // #D9E2FF - Material theme compatible
    }

    // MARK: - Background Colors (Material Theme)
    static func dynamicBackground(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.055, green: 0.078, blue: 0.082) :     // #0E1415 - Material dark background
            Color(red: 0.506, green: 0.827, blue: 0.871)       // #81D3DE - Custom light background
    }

    static func dynamicOnBackground(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.871, green: 0.894, blue: 0.894) :     // #DEE4E4 - Material dark onBackground
            Color(red: 0.090, green: 0.114, blue: 0.118)       // #171D1E - Material light onBackground
    }

    static func dynamicSurface(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.055, green: 0.078, blue: 0.082) :     // #0E1415 - Material dark surface
            Color(red: 0.961, green: 0.980, blue: 0.984)       // #F5FAFB - Material light surface
    }

    static func dynamicOnSurface(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.871, green: 0.894, blue: 0.894) :     // #DEE4E4 - Material dark onSurface
            Color(red: 0.090, green: 0.114, blue: 0.118)       // #171D1E - Material light onSurface
    }

    static func dynamicSurfaceVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.247, green: 0.282, blue: 0.290) :     // #3F484A - Material dark surfaceVariant
            Color(red: 0.859, green: 0.894, blue: 0.902)       // #DBE4E6 - Material light surfaceVariant
    }

    static func dynamicOnSurfaceVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.745, green: 0.784, blue: 0.792) :     // #BEC8CA - Material dark onSurfaceVariant
            Color(red: 0.247, green: 0.282, blue: 0.290)       // #3F484A - Material light onSurfaceVariant
    }

    // MARK: - Outline Colors (Material Theme)
    static func dynamicOutline(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.537, green: 0.573, blue: 0.580) :     // #899294 - Material dark outline
            Color(red: 0.435, green: 0.475, blue: 0.478)       // #6F797A - Material light outline
    }

    static func dynamicOutlineVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.247, green: 0.282, blue: 0.290) :     // #3F484A - Material dark outlineVariant
            Color(red: 0.745, green: 0.784, blue: 0.792)       // #BEC8CA - Material light outlineVariant
    }

    // MARK: - Convenience Methods for Current Theme
    @MainActor
    static func adaptivePrimary(_ themeManager: ThemeManager) -> Color {
        return dynamicPrimary(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnPrimary(_ themeManager: ThemeManager) -> Color {
        return dynamicOnPrimary(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptivePrimaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicPrimaryContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnPrimaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicOnPrimaryContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSecondary(_ themeManager: ThemeManager) -> Color {
        return dynamicSecondary(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnSecondary(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSecondary(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSecondaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicSecondaryContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveTertiary(_ themeManager: ThemeManager) -> Color {
        return dynamicTertiary(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveError(_ themeManager: ThemeManager) -> Color {
        return dynamicError(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnError(_ themeManager: ThemeManager) -> Color {
        return dynamicOnError(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveErrorContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicErrorContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSuccess(_ themeManager: ThemeManager) -> Color {
        return dynamicSuccess(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnSuccess(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSuccess(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSuccessContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicSuccessContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveWarning(_ themeManager: ThemeManager) -> Color {
        return dynamicWarning(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnWarning(_ themeManager: ThemeManager) -> Color {
        return dynamicOnWarning(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveWarningContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicWarningContainer(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveBackground(_ themeManager: ThemeManager) -> Color {
        return dynamicBackground(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnBackground(_ themeManager: ThemeManager) -> Color {
        return dynamicOnBackground(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSurface(_ themeManager: ThemeManager) -> Color {
        return dynamicSurface(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnSurface(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSurface(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveSurfaceVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicSurfaceVariant(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOnSurfaceVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSurfaceVariant(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOutline(_ themeManager: ThemeManager) -> Color {
        return dynamicOutline(isDark: themeManager.isDarkMode)
    }

    @MainActor
    static func adaptiveOutlineVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicOutlineVariant(isDark: themeManager.isDarkMode)
    }
}
