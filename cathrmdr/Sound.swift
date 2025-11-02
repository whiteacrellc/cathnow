/*
 * Copyright (c) 2023 White Acre Software LLC
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
import AVFoundation

// MARK: - Sound Settings View
struct SoundSettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var selectedSoundOption: String
    @Binding var hasAudioPermission: Bool
    let soundOptions: [String]
    let testSoundAction: () -> Void
    let setupAudioAction: () -> Void
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
                
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color.adaptiveWarning(themeManager))
                        
                        Text("Sound Settings")
                            .font(.iosTitle1Emphasized)
                            .foregroundStyle(Color.adaptivePrimary(themeManager))
                        
                        Text("Configure Alert Sounds")
                            .font(.iosSubheadline)
                            .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                    }
                    .padding(.top, 20)
                    
                    // Sound Selection
                    GroupBox {
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "music.note")
                                    .foregroundStyle(Color.adaptiveWarning(themeManager))
                                    .font(.title2)
                                
                                Text("Alert Sound")
                                    .font(.iosHeadline)
                                    .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 15) {
                                Text("Choose your preferred alarm sound for medical reminders")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                    .multilineTextAlignment(.center)
                                
                                Picker("Sound Selection", selection: $selectedSoundOption) {
                                    ForEach(soundOptions, id: \.self) { option in
                                        Text(option)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .background(Color.adaptiveSurface(themeManager))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.adaptivePrimary(themeManager), lineWidth: 1)
                                )
                                
                                // 🔑 Switch between setup or test
                                Button(action: {
                                    if hasAudioPermission {
                                        testSoundAction()
                                    } else {
                                        setupAudioAction()
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: hasAudioPermission ? "play.fill" : "speaker.slash.fill")
                                            .font(.iosHeadline)
                                        Text(hasAudioPermission ? "Test Sound" : "Enable Audio")
                                            .font(.iosHeadline)
                                    }
                                }
                                .buttonStyle(iOSButtonStyle(
                                    variant: .filled,
                                    isDestructive: !hasAudioPermission
                                ))
                                
                                if !hasAudioPermission {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundStyle(Color.adaptiveWarning(themeManager))
                                            .font(.iosCaption1)
                                        Text("Audio setup required for sound alerts. App will use haptic feedback as fallback.")
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
                        Label("Audio Configuration", systemImage: "slider.horizontal.3")
                            .font(.iosHeadline)
                            .foregroundStyle(Color.adaptiveWarning(themeManager))
                    }
                    .groupBoxStyle(iOSGroupBoxStyle())
                    
                    // Audio Status
                    GroupBox {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: hasAudioPermission ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(hasAudioPermission ? Color.adaptiveSuccess(themeManager) : Color.adaptiveError(themeManager))
                                    .font(.title2)
                                
                                Text("Audio Status")
                                    .font(.iosHeadline)
                                    .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Status:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text(hasAudioPermission ? "Ready" : "Disabled")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(hasAudioPermission ? Color.adaptiveSuccess(themeManager) : Color.adaptiveError(themeManager))
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Selected Sound:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text(selectedSoundOption)
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Fallback:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text("Haptic Feedback")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                    Spacer()
                                }
                                
                                if hasAudioPermission {
                                    HStack {
                                        Text("Audio Files:")
                                            .font(.iosSubheadline)
                                            .fontWeight(.medium)
                                        Text("alarm1.wav, alarm2.wav")
                                            .font(.iosCaption1)
                                            .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Current Configuration", systemImage: "info.circle")
                            .font(.iosHeadline)
                            .foregroundStyle(Color.adaptivePrimary(themeManager))
                    }
                    .groupBoxStyle(iOSGroupBoxStyle())
                    
                    Spacer() // The Spacer previously before the Tips is now the last main element in the VStack.
                }
                .padding(.horizontal, 20)
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
struct SoundSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSettingsView(
            selectedSoundOption: .constant("Alarm 1"),
            hasAudioPermission: .constant(false),
            soundOptions: ["Alarm 1", "Alarm 2"],
            testSoundAction: {
                // Assuming SoundPlayer.shared.play(soundName: "alarm1") exists
            },
            setupAudioAction: {
                // Assuming AudioManager.shared.requestAudioPermission exists
            }
        )
    }
}
