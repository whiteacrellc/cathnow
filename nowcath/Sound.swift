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
                // Material 3 background
                Color.material3SurfaceGradient
                .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: "speaker.wave.3.fill")
                            .font(.system(size: 40))
                            .foregroundStyle(Color.material3Warning)
                        
                        Text("Sound Settings")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.material3Primary)
                        
                        Text("Configure Alert Sounds")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Sound Selection
                    GroupBox {
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: "music.note")
                                    .foregroundStyle(Color.material3Warning)
                                    .font(.title2)
                                
                                Text("Alert Sound")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 15) {
                                Text("Choose your preferred alarm sound for medical reminders")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.material3Primary)
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
                                            .font(.title3)
                                        Text(hasAudioPermission ? "Test Sound" : "Enable Audio")
                                            .font(.subheadline)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(
                                        hasAudioPermission ?
                                            Color.material3SuccessGradient :
                                            Color.material3ErrorGradient
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                if !hasAudioPermission {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundStyle(.orange)
                                            .font(.caption)
                                        Text("Audio setup required for sound alerts. App will use haptic feedback as fallback.")
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.top, 5)
                                }
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Audio Configuration", systemImage: "slider.horizontal.3")
                            .font(.headline)
                            .foregroundStyle(Color.material3Warning)
                    }
                    .groupBoxStyle(Material3GroupBoxStyle())
                    
                    // Audio Status
                    GroupBox {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: hasAudioPermission ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .foregroundStyle(hasAudioPermission ? Color.material3Success : Color.material3Error)
                                    .font(.title2)
                                
                                Text("Audio Status")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text("Status:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text(hasAudioPermission ? "Ready" : "Disabled")
                                        .font(.subheadline)
                                        .foregroundStyle(hasAudioPermission ? Color.material3Success : Color.material3Error)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Selected Sound:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text(selectedSoundOption)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Fallback:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                    Text("Haptic Feedback")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                                
                                if hasAudioPermission {
                                    HStack {
                                        Text("Audio Files:")
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text("alarm1.wav, alarm2.wav")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Current Configuration", systemImage: "info.circle")
                            .font(.headline)
                            .foregroundStyle(Color.material3Primary)
                    }
                    .groupBoxStyle(Material3GroupBoxStyle())
                    
                    // Audio Tips
                    GroupBox {
                        VStack(spacing: 15) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                    .foregroundStyle(Color.material3Warning)
                                    .font(.title2)
                                
                                Text("Audio Tips")
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("• Test different alarm sounds to find what works best for you")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                Text("• Ensure your device volume is at an appropriate level")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                Text("• Both in-app and notification sounds will use your selection")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                Text("• Haptic feedback provides silent alerts when audio is unavailable")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(20)
                    } label: {
                        Label("Usage Tips", systemImage: "questionmark.circle")
                            .font(.headline)
                            .foregroundStyle(Color.material3Warning)
                    }
                    .groupBoxStyle(Material3GroupBoxStyle())
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingMainMenu = true }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(Color.material3Primary)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(Color.material3Primary)
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
