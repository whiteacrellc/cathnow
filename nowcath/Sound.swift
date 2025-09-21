import SwiftUI
import AVFoundation

// MARK: - Sound Settings View
struct SoundSettingsView: View {
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
                // iOS Design System background
                Color.iosBackgroundGradient
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color.iosMedicalWarning)
                        
                        Text("Sound Settings")
                            .font(.iosTitle1Emphasized)
                            .foregroundStyle(Color.iosMedicalPrimary)
                        
                        Text("Configure Alert Sounds")
                            .font(.iosSubheadline)
                            .foregroundStyle(Color.iosSecondaryLabel)
                    }
                    .padding(.top, 20)
                    
                    // Sound Selection
                    GroupBox {
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "music.note")
                                    .foregroundStyle(Color.iosMedicalWarning)
                                    .font(.title2)
                                
                                Text("Alert Sound")
                                    .font(.iosHeadline)
                                    .foregroundStyle(Color.iosLabel)
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 15) {
                                Text("Choose your preferred alarm sound for medical reminders")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.iosSecondaryLabel)
                                    .multilineTextAlignment(.center)
                                
                                Picker("Sound Selection", selection: $selectedSoundOption) {
                                    ForEach(soundOptions, id: \.self) { option in
                                        Text(option)
                                    }
                                }
                                .pickerStyle(SegmentedPickerStyle())
                                
                                Button(action: testSoundAction) {
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
                                            .foregroundStyle(Color.iosMedicalWarning)
                                            .font(.iosCaption1)
                                        Text("Audio setup required for sound alerts. App will use haptic feedback as fallback.")
                                            .font(.iosCaption2)
                                            .foregroundStyle(Color.iosSecondaryLabel)
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
                            .foregroundStyle(Color.iosMedicalWarning)
                    }
                    .groupBoxStyle(iOSGroupBoxStyle())
                    
                    // Audio Status
                    GroupBox {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: hasAudioPermission ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(hasAudioPermission ? Color.iosMedicalSuccess : Color.iosMedicalError)
                                    .font(.title2)
                                
                                Text("Audio Status")
                                    .font(.iosHeadline)
                                    .foregroundStyle(Color.iosLabel)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Status:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text(hasAudioPermission ? "Ready" : "Disabled")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(hasAudioPermission ? Color.iosMedicalSuccess : Color.iosMedicalError)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Selected Sound:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text(selectedSoundOption)
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.iosSecondaryLabel)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Fallback:")
                                        .font(.iosSubheadline)
                                        .fontWeight(.medium)
                                    Text("Haptic Feedback")
                                        .font(.iosSubheadline)
                                        .foregroundStyle(Color.iosSecondaryLabel)
                                    Spacer()
                                }
                                
                                if hasAudioPermission {
                                    HStack {
                                        Text("Audio Files:")
                                            .font(.iosSubheadline)
                                            .fontWeight(.medium)
                                        Text("alarm1.wav, alarm2.wav")
                                            .font(.iosCaption1)
                                            .foregroundStyle(Color.iosSecondaryLabel)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Current Configuration", systemImage: "info.circle")
                            .font(.iosHeadline)
                            .foregroundStyle(Color.iosMedicalPrimary)
                    }
                    .groupBoxStyle(iOSGroupBoxStyle())
                    
                    // Audio Tips
                    GroupBox {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundStyle(Color.iosMedicalWarning)
                                    .font(.title2)
                                
                                Text("Audio Tips")
                                    .font(.iosHeadline)
                                    .foregroundStyle(Color.iosLabel)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("• Test different alarm sounds to find what works best for you")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.iosSecondaryLabel)
                                
                                Text("• Ensure your device volume is at an appropriate level")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.iosSecondaryLabel)
                                
                                Text("• Both in-app and notification sounds will use your selection")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.iosSecondaryLabel)
                                
                                Text("• Haptic feedback provides silent alerts when audio is unavailable")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.iosSecondaryLabel)
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Usage Tips", systemImage: "questionmark.circle")
                            .font(.iosHeadline)
                            .foregroundStyle(Color.iosMedicalWarning)
                    }
                    .groupBoxStyle(iOSGroupBoxStyle())
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingMainMenu = true }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(Color.iosMedicalPrimary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(Color.iosMedicalPrimary)
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
            hasAudioPermission: .constant(true),
            soundOptions: ["Alarm 1", "Alarm 2"],
            testSoundAction: {},
            setupAudioAction: {}
        )
    }
}
