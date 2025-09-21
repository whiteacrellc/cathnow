import SwiftUI

struct PrivacyView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingMainMenu = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Medical gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.95, green: 0.97, blue: 1.0),
                        Color(red: 0.98, green: 0.99, blue: 1.0)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        // Header
                        VStack(spacing: 15) {
                            Image(systemName: "lock.shield.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                            
                            Text("Privacy Policy")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                            
                            Text("White Acre Software LLC")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                        
                        // Privacy Statement Overview
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "checkmark.shield.fill")
                                        .foregroundStyle(.green)
                                        .font(.title2)
                                    
                                    Text("Privacy Commitment")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("White Acre Software LLC is committed to protecting your privacy and ensuring the security of your personal information. This privacy policy explains our data practices for the Cath Now application.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    Text("Effective Date: September 2025")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .italic()
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Our Commitment", systemImage: "heart.fill")
                                .font(.headline)
                                .foregroundStyle(.green)
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Data Collection
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "eye.slash.fill")
                                        .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                                        .font(.title2)
                                    
                                    Text("Data Collection")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("White Acre Software LLC does not collect, store, or transmit any personal data or usage information from the Cath Now application.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .fontWeight(.medium)
                                    
                                    Text("• No personal health information is collected")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No usage analytics or tracking data is gathered")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No device identifiers or personal identifiers are accessed")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No network communications for data collection purposes")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Zero Data Collection", systemImage: "hand.raised.fill")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Local Storage
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "internaldrive.fill")
                                        .foregroundStyle(Color(red: 0.8, green: 0.5, blue: 0.2))
                                        .font(.title2)
                                    
                                    Text("Local Data Storage")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("All application settings and preferences are stored locally on your device using iOS standard secure storage mechanisms.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    
                                    Text("• Alarm intervals and settings remain on your device only")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Sound preferences are stored locally")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No data synchronization or cloud storage")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Data is removed when the application is deleted")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Local Storage Only", systemImage: "lock.fill")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.8, green: 0.5, blue: 0.2))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // System Permissions
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "bell.badge.fill")
                                        .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                                        .font(.title2)
                                    
                                    Text("System Permissions")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("The application requests only essential system permissions required for core functionality.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    
                                    Text("• Notification permission: Required for medical reminders")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Audio playback: Used only for local alarm sounds")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No microphone access: Audio is playback only")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No location, camera, or contact access requested")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Minimal Permissions", systemImage: "checkmark.circle.fill")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Third Party Services
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "network.slash")
                                        .foregroundStyle(.purple)
                                        .font(.title2)
                                    
                                    Text("Third-Party Services")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("The Cath Now application does not integrate with any third-party services, analytics platforms, or advertising networks.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .fontWeight(.medium)
                                    
                                    Text("• No third-party SDKs or frameworks that collect data")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No advertising networks or tracking pixels")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• No social media integrations")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Fully offline operation capability")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("No Third Parties", systemImage: "shield.lefthalf.filled")
                                .font(.headline)
                                .foregroundStyle(.purple)
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Medical Disclaimer
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "cross.case.fill")
                                        .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                                        .font(.title2)
                                    
                                    Text("Medical Disclaimer")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("The Cath Now application is designed as a reminder tool to assist with medical routine management.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    
                                    Text("• This application is not a medical device")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Always consult healthcare professionals for medical advice")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Application functionality depends on device operation")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Text("• Users are responsible for following medical guidance")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Medical Use Disclaimer", systemImage: "stethoscope")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Contact Information
                        GroupBox {
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundStyle(.blue)
                                        .font(.title2)
                                    
                                    Text("Contact Information")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading, spacing: 15) {
                                    Text("If you have questions about this privacy policy or our data practices, please contact White Acre Software LLC.")
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    
                                    Text("Company: White Acre Software LLC")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .fontWeight(.medium)
                                    
                                    Text("This privacy policy may be updated to reflect changes in our practices or legal requirements. The effective date will be updated accordingly.")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .italic()
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Contact & Updates", systemImage: "questionmark.circle.fill")
                                .font(.headline)
                                .foregroundStyle(.blue)
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Footer
                        VStack(spacing: 10) {
                            Text("© 2025 White Acre Software LLC")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                            
                            Text("Last Updated: September 2025")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                            
                            Text("This privacy policy governs the use of the Cath Now application")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingMainMenu = true }) {
                        Image(systemName: "line.horizontal.3")
                            .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
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
struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
