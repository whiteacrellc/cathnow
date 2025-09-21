import SwiftUI

// MARK: - Theme Manager
class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .light

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
            // Follow system appearance
            return UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
}

// MARK: - Dynamic Color System
extension Color {
    // MARK: - Primary Colors (Medical Blue)
    static func dynamicPrimary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.478, green: 0.678, blue: 1.0) :       // #7AADFF - Lighter blue for dark mode
            Color(red: 0.0, green: 0.478, blue: 1.0)           // #007AFF - iOS Blue for light mode
    }

    static func dynamicOnPrimary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.0, blue: 0.0) :           // Black text on light primary
            Color(red: 1.0, green: 1.0, blue: 1.0)             // White text on dark primary
    }

    static func dynamicPrimaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.294, blue: 0.612) :       // #004B9C - Darker container for dark mode
            Color(red: 0.816, green: 0.910, blue: 1.0)         // #D0E8FF - Light container for light mode
    }

    static func dynamicOnPrimaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.816, green: 0.910, blue: 1.0) :       // Light text on dark container
            Color(red: 0.0, green: 0.294, blue: 0.612)         // Dark text on light container
    }

    // MARK: - Secondary Colors (Medical Teal)
    static func dynamicSecondary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.588, green: 0.871, blue: 0.871) :     // #96DEDE - Light teal for dark mode
            Color(red: 0.188, green: 0.690, blue: 0.780)       // #30B0C7 - Teal for light mode
    }

    static func dynamicOnSecondary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.0, blue: 0.0) :           // Black text
            Color(red: 1.0, green: 1.0, blue: 1.0)             // White text
    }

    static func dynamicSecondaryContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.435, blue: 0.490) :       // #006F7D - Dark teal container
            Color(red: 0.698, green: 0.949, blue: 0.976)       // #B2F2F9 - Light teal container
    }

    // MARK: - Tertiary Colors (Medical Purple)
    static func dynamicTertiary(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.871, green: 0.690, blue: 0.871) :     // #DEB0DE - Light purple for dark mode
            Color(red: 0.686, green: 0.322, blue: 0.871)       // #AF52DE - Purple for light mode
    }

    // MARK: - Error Colors (Medical Red)
    static func dynamicError(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 1.0, green: 0.674, blue: 0.678) :       // #FFACAD - Light red for dark mode
            Color(red: 1.0, green: 0.231, blue: 0.188)         // #FF3B30 - Red for light mode
    }

    static func dynamicOnError(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.0, blue: 0.0) :           // Black text
            Color(red: 1.0, green: 1.0, blue: 1.0)             // White text
    }

    static func dynamicErrorContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.616, green: 0.0, blue: 0.0) :         // #9D0000 - Dark red container
            Color(red: 1.0, green: 0.898, blue: 0.898)         // #FFE5E5 - Light red container
    }

    // MARK: - Success Colors (Medical Green)
    static func dynamicSuccess(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.545, green: 0.871, blue: 0.576) :     // #8BDE93 - Light green for dark mode
            Color(red: 0.204, green: 0.780, blue: 0.349)       // #34C759 - Green for light mode
    }

    static func dynamicOnSuccess(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.0, blue: 0.0) :           // Black text
            Color(red: 1.0, green: 1.0, blue: 1.0)             // White text
    }

    static func dynamicSuccessContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.490, blue: 0.157) :       // #007D28 - Dark green container
            Color(red: 0.831, green: 0.976, blue: 0.863)       // #D4F9DC - Light green container
    }

    // MARK: - Warning Colors (Medical Orange)
    static func dynamicWarning(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 1.0, green: 0.855, blue: 0.545) :       // #FFDA8B - Light orange for dark mode
            Color(red: 1.0, green: 0.584, blue: 0.0)           // #FF9500 - Orange for light mode
    }

    static func dynamicOnWarning(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.0, green: 0.0, blue: 0.0) :           // Black text
            Color(red: 1.0, green: 1.0, blue: 1.0)             // White text
    }

    static func dynamicWarningContainer(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.612, green: 0.294, blue: 0.0) :       // #9C4B00 - Dark orange container
            Color(red: 1.0, green: 0.922, blue: 0.816)         // #FFEBCF - Light orange container
    }

    // MARK: - Background Colors
    static func dynamicBackground(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.071, green: 0.071, blue: 0.071) :     // #121212 - Material Dark background
            Color(red: 1.0, green: 1.0, blue: 1.0)             // #FFFFFF - White background
    }

    static func dynamicOnBackground(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.898, green: 0.898, blue: 0.898) :     // #E5E5E5 - Light text
            Color(red: 0.071, green: 0.071, blue: 0.071)       // #121212 - Dark text
    }

    static func dynamicSurface(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.149, green: 0.149, blue: 0.149) :     // #262626 - Dark surface
            Color(red: 0.980, green: 0.980, blue: 0.980)       // #FAFAFA - Light surface
    }

    static func dynamicOnSurface(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.898, green: 0.898, blue: 0.898) :     // #E5E5E5 - Light text
            Color(red: 0.071, green: 0.071, blue: 0.071)       // #121212 - Dark text
    }

    static func dynamicSurfaceVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.196, green: 0.196, blue: 0.196) :     // #323232 - Dark surface variant
            Color(red: 0.949, green: 0.949, blue: 0.949)       // #F2F2F2 - Light surface variant
    }

    static func dynamicOnSurfaceVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.784, green: 0.784, blue: 0.784) :     // #C8C8C8 - Medium light text
            Color(red: 0.294, green: 0.294, blue: 0.294)       // #4B4B4B - Medium dark text
    }

    // MARK: - Outline Colors
    static func dynamicOutline(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.471, green: 0.471, blue: 0.471) :     // #787878 - Light outline
            Color(red: 0.741, green: 0.741, blue: 0.741)       // #BDBDBD - Dark outline
    }

    static func dynamicOutlineVariant(isDark: Bool) -> Color {
        return isDark ?
            Color(red: 0.294, green: 0.294, blue: 0.294) :     // #4B4B4B - Darker outline
            Color(red: 0.898, green: 0.898, blue: 0.898)       // #E5E5E5 - Lighter outline
    }

    // MARK: - Convenience Methods for Current Theme
    static func adaptivePrimary(_ themeManager: ThemeManager) -> Color {
        return dynamicPrimary(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnPrimary(_ themeManager: ThemeManager) -> Color {
        return dynamicOnPrimary(isDark: themeManager.isDarkMode)
    }

    static func adaptivePrimaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicPrimaryContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnPrimaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicOnPrimaryContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSecondary(_ themeManager: ThemeManager) -> Color {
        return dynamicSecondary(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnSecondary(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSecondary(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSecondaryContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicSecondaryContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveTertiary(_ themeManager: ThemeManager) -> Color {
        return dynamicTertiary(isDark: themeManager.isDarkMode)
    }

    static func adaptiveError(_ themeManager: ThemeManager) -> Color {
        return dynamicError(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnError(_ themeManager: ThemeManager) -> Color {
        return dynamicOnError(isDark: themeManager.isDarkMode)
    }

    static func adaptiveErrorContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicErrorContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSuccess(_ themeManager: ThemeManager) -> Color {
        return dynamicSuccess(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnSuccess(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSuccess(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSuccessContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicSuccessContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveWarning(_ themeManager: ThemeManager) -> Color {
        return dynamicWarning(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnWarning(_ themeManager: ThemeManager) -> Color {
        return dynamicOnWarning(isDark: themeManager.isDarkMode)
    }

    static func adaptiveWarningContainer(_ themeManager: ThemeManager) -> Color {
        return dynamicWarningContainer(isDark: themeManager.isDarkMode)
    }

    static func adaptiveBackground(_ themeManager: ThemeManager) -> Color {
        return dynamicBackground(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnBackground(_ themeManager: ThemeManager) -> Color {
        return dynamicOnBackground(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSurface(_ themeManager: ThemeManager) -> Color {
        return dynamicSurface(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnSurface(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSurface(isDark: themeManager.isDarkMode)
    }

    static func adaptiveSurfaceVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicSurfaceVariant(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOnSurfaceVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicOnSurfaceVariant(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOutline(_ themeManager: ThemeManager) -> Color {
        return dynamicOutline(isDark: themeManager.isDarkMode)
    }

    static func adaptiveOutlineVariant(_ themeManager: ThemeManager) -> Color {
        return dynamicOutlineVariant(isDark: themeManager.isDarkMode)
    }
}