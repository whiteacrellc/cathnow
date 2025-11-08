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

// MARK: - App Settings Manager
@MainActor
class AppSettingsManager: ObservableObject {
    static let shared = AppSettingsManager()

    @Published var showDynamicIsland: Bool {
        didSet {
            UserDefaults.standard.set(showDynamicIsland, forKey: "ShowDynamicIsland")
        }
    }

    @Published var showLockScreen: Bool {
        didSet {
            UserDefaults.standard.set(showLockScreen, forKey: "ShowLockScreen")
        }
    }

    private init() {
        // Load saved preferences, default to showing both
        self.showDynamicIsland = UserDefaults.standard.object(forKey: "ShowDynamicIsland") as? Bool ?? true
        self.showLockScreen = UserDefaults.standard.object(forKey: "ShowLockScreen") as? Bool ?? true
    }
}

// MARK: - App Settings View
struct AppSettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var settingsManager = AppSettingsManager.shared
    @Environment(\.dismiss) private var dismiss
    @State private var showingMainMenu = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [Color.adaptiveBackground(themeManager),
                             Color.adaptiveSurface(themeManager)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        // Header
                        VStack(spacing: 15) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.adaptivePrimary(themeManager))

                            Text("App Settings")
                                .font(.iosTitle1Emphasized)
                                .foregroundStyle(Color.adaptivePrimary(themeManager))

                            Text("Customize Your Experience")
                                .font(.iosSubheadline)
                                .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                        }
                        .padding(.top, 20)

                        // Theme Settings
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "paintbrush.fill")
                                        .foregroundStyle(Color.adaptivePrimary(themeManager))
                                        .font(.title2)

                                    Text("Appearance")
                                        .font(.iosHeadline)
                                        .foregroundStyle(Color.adaptiveOnBackground(themeManager))

                                    Spacer()
                                }

                                VStack(spacing: 15) {
                                    Text("Choose your preferred app theme")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                        .multilineTextAlignment(.center)

                                    Picker("Theme", selection: $themeManager.currentTheme) {
                                        ForEach(ThemeManager.AppTheme.allCases, id: \.self) { theme in
                                            Text(theme.displayName).tag(theme)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .onChange(of: themeManager.currentTheme) { newValue in
                                        themeManager.setTheme(newValue)
                                    }
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Theme Selection", systemImage: "paintpalette")
                                .font(.iosHeadline)
                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                        }
                        .groupBoxStyle(iOSGroupBoxStyle())

                        // Live Activity Settings
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "app.badge.fill")
                                        .foregroundStyle(Color.adaptiveSecondary(themeManager))
                                        .font(.title2)

                                    Text("Live Activity Display")
                                        .font(.iosHeadline)
                                        .foregroundStyle(Color.adaptiveOnBackground(themeManager))

                                    Spacer()
                                }

                                VStack(spacing: 15) {
                                    Text("Choose where to display your timer")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                        .multilineTextAlignment(.center)

                                    HStack {
                                        Image(systemName: "info.circle")
                                            .foregroundStyle(Color.adaptiveTertiary(themeManager))
                                            .font(.iosCaption1)
                                        Text("Live Activities appear in both locations when active. Dynamic Island requires iPhone 14 Pro or newer.")
                                            .font(.iosCaption2)
                                            .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.horizontal, 8)

                                    // Dynamic Island Toggle
                                    Toggle(isOn: $settingsManager.showDynamicIsland) {
                                        HStack {
                                            Image(systemName: "iphone.gen3")
                                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Dynamic Island")
                                                    .font(.iosSubheadline)
                                                    .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                                Text("Show timer in Dynamic Island")
                                                    .font(.iosCaption1)
                                                    .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                            }
                                        }
                                    }
                                    .tint(Color.adaptivePrimary(themeManager))

                                    Divider()
                                        .background(Color.adaptiveOutline(themeManager).opacity(0.5))

                                    // Lock Screen Toggle
                                    Toggle(isOn: $settingsManager.showLockScreen) {
                                        HStack {
                                            Image(systemName: "lock.shield")
                                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text("Lock Screen")
                                                    .font(.iosSubheadline)
                                                    .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                                Text("Show timer on lock screen")
                                                    .font(.iosCaption1)
                                                    .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                            }
                                        }
                                    }
                                    .tint(Color.adaptivePrimary(themeManager))

                                    if !settingsManager.showDynamicIsland && !settingsManager.showLockScreen {
                                        HStack {
                                            Image(systemName: "exclamationmark.triangle.fill")
                                                .foregroundStyle(Color.adaptiveWarning(themeManager))
                                                .font(.iosCaption1)
                                            Text("At least one display option should be enabled for best experience.")
                                                .font(.iosCaption2)
                                                .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                                .multilineTextAlignment(.leading)
                                        }
                                        .padding(.top, 5)
                                    }
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Live Activity Options", systemImage: "bell.badge")
                                .font(.iosHeadline)
                                .foregroundStyle(Color.adaptiveSecondary(themeManager))
                        }
                        .groupBoxStyle(iOSGroupBoxStyle())

                        // Current Settings Summary
                        GroupBox {
                            VStack(spacing: 15) {
                                HStack {
                                    Image(systemName: "info.circle.fill")
                                        .foregroundStyle(Color.adaptiveTertiary(themeManager))
                                        .font(.title2)

                                    Text("Current Settings")
                                        .font(.iosHeadline)
                                        .foregroundStyle(Color.adaptiveOnBackground(themeManager))

                                    Spacer()
                                }

                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Theme:")
                                            .font(.iosSubheadline)
                                            .fontWeight(.medium)
                                        Text(themeManager.currentTheme.displayName)
                                            .font(.iosSubheadline)
                                            .foregroundStyle(Color.adaptivePrimary(themeManager))
                                        Spacer()
                                    }

                                    HStack {
                                        Text("Dynamic Island:")
                                            .font(.iosSubheadline)
                                            .fontWeight(.medium)
                                        Text(settingsManager.showDynamicIsland ? "Enabled" : "Disabled")
                                            .font(.iosSubheadline)
                                            .foregroundStyle(settingsManager.showDynamicIsland ? Color.adaptiveSuccess(themeManager) : Color.adaptiveError(themeManager))
                                        Spacer()
                                    }

                                    HStack {
                                        Text("Lock Screen:")
                                            .font(.iosSubheadline)
                                            .fontWeight(.medium)
                                        Text(settingsManager.showLockScreen ? "Enabled" : "Disabled")
                                            .font(.iosSubheadline)
                                            .foregroundStyle(settingsManager.showLockScreen ? Color.adaptiveSuccess(themeManager) : Color.adaptiveError(themeManager))
                                        Spacer()
                                    }
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Summary", systemImage: "list.bullet.rectangle")
                                .font(.iosHeadline)
                                .foregroundStyle(Color.adaptiveTertiary(themeManager))
                        }
                        .groupBoxStyle(iOSGroupBoxStyle())

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingMainMenu = true }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(Color.adaptivePrimary(themeManager))
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(Color.adaptivePrimary(themeManager))
                }
            }
        }
        .confirmationDialog("Navigation", isPresented: $showingMainMenu, titleVisibility: .visible) {
            Button("Return to Main Screen") {
                dismiss()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose an option")
        }
    }
}

// MARK: - Preview
struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
            .environmentObject(ThemeManager())
    }
}
