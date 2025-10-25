import SwiftUI
import UserNotifications
import AVFoundation
import AudioToolbox
import ActivityKit

struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var intervalText = "4:00"
    @State private var nextAlertDate: Date?
    @State private var intervalSeconds: TimeInterval = 0
    @State private var countdownText = "No alarm set"
    @State private var statusText = "Ready to set alarm"
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    @State private var selectedSoundOption = "Alarm 1"
    @State private var hasAudioPermission = false
    @State private var showingAudioPermissionAlert = false
    @State private var showingSettingsMenu = false
    @State private var showingPrivacyPage = false
    @State private var showingSoundSettings = false

    // Live Activity manager
    @StateObject private var liveActivityManager = LiveActivityManager.shared

    // Audio player for immediate sound feedback
    @State private var audioPlayer: AVAudioPlayer?
    
    // Timer to update countdown every second for real-time updates
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Sound options
    let soundOptions = ["Alarm 1", "Alarm 2", "System Alert", "System Chime", "System Bell", "Default Ringtone", "Critical Alert", "SMS Tone"]

    // MARK: - Theme Management
    private func cycleTheme() {
        let themes = ThemeManager.AppTheme.allCases
        if let currentIndex = themes.firstIndex(of: themeManager.currentTheme) {
            let nextIndex = (currentIndex + 1) % themes.count
            themeManager.setTheme(themes[nextIndex])
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Dynamic theme background
                LinearGradient(
                    colors: [
                        Color.adaptiveBackground(themeManager),
                        Color.adaptiveSurface(themeManager)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        // Header Section
                        VStack(spacing: 15) {
                            HStack {
                                Spacer()
                                
                                Button(action: { showingSettingsMenu = true }) {
                                    Image(systemName: "ellipsis.circle.fill")
                                        .font(.title2)
                                        .foregroundStyle(Color.adaptivePrimary(themeManager))
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            
                            Image(systemName: "cross.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                            
                            Text("Cath Now")
                                .font(.iosLargeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                        }
                        .padding(.top, 20)
                        
                        // Input Section
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "clock.circle.fill")
                                        .foregroundStyle(Color.adaptivePrimary(themeManager))
                                        .font(.title2)
                                    
                                    Text("Alarm Interval")
                                        .font(.iosHeadline)
                                        .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                    
                                    Spacer()
                                }
                                
                                Text("Enter the alarm interval in the format HH:MM")
                                    .font(.iosSubheadline)
                                    .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Spacer()
                                    
                                    TextField("HH:MM", text: $intervalText)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .foregroundColor(Color.adaptiveOnBackground(themeManager))
                                        .multilineTextAlignment(.center)
                                        .frame(width: 120, height: 50)
                                        .background(Color.adaptiveSurface(themeManager))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.adaptivePrimary(themeManager), lineWidth: 2)
                                        )
                                        .shadow(color: Color.iosSystemFill.opacity(0.2), radius: 2, x: 0, y: 1)
                                    
                                    Spacer()
                                }
                                
                                Button(action: startButtonTapped) {
                                    HStack {
                                        Image(systemName: statusText.contains("active") ? "arrow.clockwise.circle.fill" : "play.circle.fill")
                                            .font(.iosHeadline)
                                        Text(statusText.contains("active") ? "Update Alarm" : "Start Alarm")
                                            .font(.iosHeadline)
                                    }
                                }
                                .buttonStyle(iOSButtonStyle(
                                    variant: .filled,
                                    isDestructive: false
                                ))
                                .scaleEffect(1.0)
                                .animation(.easeInOut(duration: 0.1), value: showingErrorAlert)
                            }
                            .padding(20)
                        } label: {
                            Label("Alarm Configuration", systemImage: "gear.badge")
                                .font(.iosHeadline)
                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                        }
                        .groupBoxStyle(iOSGroupBoxStyle())
                        
                        // Status Section
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "timer.circle.fill")
                                        .foregroundStyle(Color.adaptiveError(themeManager))
                                        .font(.title2)
                                    
                                    Text("Next Alarm")
                                        .font(.iosHeadline)
                                        .foregroundStyle(Color.adaptiveOnBackground(themeManager))
                                    
                                    Spacer()
                                }
                                
                                VStack(spacing: 15) {
                                    Text(countdownText)
                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                        .foregroundStyle(
                                            countdownText == "No alarm set" ?
                                                Color.adaptiveOnSurfaceVariant(themeManager) : Color.adaptiveError(themeManager)
                                        )
                                        .contentTransition(.numericText())
                                    
                                    Divider()
                                        .background(Color.adaptiveOutline(themeManager).opacity(0.5))
                                    
                                    VStack(spacing: 8) {
                                        HStack {
                                            Image(systemName: statusText.contains("active") ? "checkmark.circle.fill" : "circle")
                                                .foregroundStyle(statusText.contains("active") ? Color.adaptiveSuccess(themeManager) : Color.adaptiveOnSurfaceVariant(themeManager))
                                                .font(.title3)
                                            
                                            Text(statusText)
                                                .font(.iosSubheadline)
                                                .foregroundStyle(Color.adaptivePrimary(themeManager))
                                            
                                            Spacer()
                                        }
                                        
                                        if statusText.contains("active") {
                                            HStack {
                                                Image(systemName: hasAudioPermission ? "speaker.wave.2" : "speaker.slash")
                                                    .foregroundStyle(hasAudioPermission ? Color.adaptiveWarning(themeManager) : Color.adaptiveOnSurfaceVariant(themeManager))
                                                    .font(.caption)
                                                
                                                Text(hasAudioPermission ? "Sound: \(selectedSoundOption)" : "Sound: Disabled")
                                                    .font(.iosCaption1)
                                                    .foregroundStyle(Color.adaptiveOnSurfaceVariant(themeManager))
                                                
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Status Monitor", systemImage: "heart.text.square")
                                .font(.iosHeadline)
                                .foregroundStyle(Color.adaptiveError(themeManager))
                        }
                        .groupBoxStyle(iOSGroupBoxStyle())
                        
                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarHidden(true)
        }
        .onReceive(timer) { _ in
            updateCountdown()
        }
        .onAppear {
            updateCountdown()
            checkAudioPermission()
        }
        .alert("Invalid Input", isPresented: $showingErrorAlert) {
            Button("OK") {
                // Optional: Add any action when OK is pressed
            }
        } message: {
            Text(errorMessage)
        }
        .alert("Audio Setup Required", isPresented: $showingAudioPermissionAlert) {
            Button("Try Again") {
                setupAudioSession()
            }
            Button("Continue Without Sound", role: .cancel) {
                hasAudioPermission = false
            }
        } message: {
            Text("Unable to set up audio playback. You can continue using the app with haptic feedback only, or try enabling audio again.")
        }
        .confirmationDialog("Settings", isPresented: $showingSettingsMenu, titleVisibility: .visible) {
            Button("Sound Settings") {
                showingSoundSettings = true
            }

            Button("Theme: \(themeManager.currentTheme.displayName)") {
                cycleTheme()
            }

            Button("Privacy Policy") {
                showingPrivacyPage = true
            }

            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Choose an option")
        }
        .sheet(isPresented: $showingPrivacyPage) {
            PrivacyView()
        }
        .sheet(isPresented: $showingSoundSettings) {
            SoundSettingsView(
                selectedSoundOption: $selectedSoundOption,
                hasAudioPermission: $hasAudioPermission,
                soundOptions: soundOptions,
                testSoundAction: testSound,
                setupAudioAction: setupAudioSession
            )
        }
    }
    
    func checkAudioPermission() {
        // For audio playback (not recording), we don't need microphone permission
        // We'll use a simpler approach that doesn't require privacy permissions
        hasAudioPermission = true
    }
    
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func setupAudioSession() {
        do {
            // Set category to playback only - no microphone access needed
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true)
            hasAudioPermission = true
        } catch {
            print("Failed to set up audio session: \(error)")
            hasAudioPermission = false
        }
    }
    
    func testSound() {
        if !hasAudioPermission {
            // Try to setup audio session again
            setupAudioSession()
            if !hasAudioPermission {
                showingAudioPermissionAlert = true
                return
            }
        }
        
        playAlertSound()
        
        // Haptic feedback for test
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    func playAlertSound() {
        guard hasAudioPermission else {
            // Fallback to haptic feedback only if no audio permission
            let impactFeedback = UIImpactFeedbackGenerator(style: .heavy)
            impactFeedback.impactOccurred()
            return
        }

        // Play audio based on selected sound option
        switch selectedSoundOption {
        case "Alarm 1":
            playAudioFile(named: "alarm1.wav")
        case "Alarm 2":
            playAudioFile(named: "alarm2.wav")
        case "System Alert":
            AudioServicesPlaySystemSound(1007) // System alert sound
        case "System Chime":
            AudioServicesPlaySystemSound(1016) // System chime sound
        case "System Bell":
            AudioServicesPlaySystemSound(1013) // System bell sound
        case "Default Ringtone":
            AudioServicesPlaySystemSound(1005) // Default ringtone sound
        case "Critical Alert":
            AudioServicesPlaySystemSound(1006) // System critical alert
        case "SMS Tone":
            AudioServicesPlaySystemSound(1007) // SMS received sound
        default:
            playAudioFile(named: "alarm1.wav")
        }
    }
    
    func playAudioFile(named fileName: String) {
        guard let soundURL = Bundle.main.url(forResource: fileName.replacingOccurrences(of: ".wav", with: ""), withExtension: "wav") else {
            print("Could not find sound file: \(fileName)")
            // Fallback to system sound
            AudioServicesPlaySystemSound(1007)
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound file: \(error)")
            // Fallback to system sound
            AudioServicesPlaySystemSound(1007)
        }
    }
    
    func startButtonTapped() {
        // Hide keyboard
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        guard !intervalText.isEmpty else {
            showErrorNotification(message: "Please enter a valid time interval.")
            return
        }
        
        guard let interval = parseTimeInterval(intervalText) else {
            showErrorNotification(message: "Please enter time in HH:MM format (e.g., 4:00).")
            return
        }
        
        // Cancel all existing notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        // End any existing Live Activity
        if #available(iOS 16.1, *) {
            liveActivityManager.endLiveActivity()
        }
        
        intervalSeconds = interval
        scheduleRepeatingNotifications()
        
        statusText = "Alarm active - repeats every \(intervalText)"
        updateCountdown()

        // Start Live Activity for Dynamic Island
        if #available(iOS 16.1, *), let nextAlert = nextAlertDate {
            liveActivityManager.startLiveActivity(
                intervalText: intervalText,
                intervalSeconds: intervalSeconds,
                nextAlarmTime: nextAlert
            )
        }

        // Play confirmation sound (if permission available)
        if hasAudioPermission {
            playAlertSound()
        }

        // Success haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    func parseTimeInterval(_ timeString: String) -> TimeInterval? {
        let components = timeString.split(separator: ":")
        guard components.count == 2,
              let hours = Int(components[0]),
              let minutes = Int(components[1]),
              hours >= 0, hours <= 23,
              minutes >= 0, minutes <= 59 else {
            return nil
        }
        
        return TimeInterval(hours * 3600 + minutes * 60)
    }
    
    func scheduleRepeatingNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Cath Now"
        content.body = "Time to cath!"
        content.badge = 1
        
        // Set notification sound based on selection
        switch selectedSoundOption {
        case "Alarm 1":
            if Bundle.main.url(forResource: "alarm1", withExtension: "wav") != nil {
                content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm1.wav"))
            } else {
                content.sound = .default
            }
        case "Alarm 2":
            if Bundle.main.url(forResource: "alarm2", withExtension: "wav") != nil {
                content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm2.wav"))
            } else {
                content.sound = .default
            }
        case "System Alert":
            content.sound = .defaultCritical
        case "System Chime":
            content.sound = .default
        case "System Bell":
            content.sound = .default
        case "Default Ringtone":
            content.sound = .defaultRingtone
        case "Critical Alert":
            content.sound = .defaultCritical
        case "SMS Tone":
            content.sound = .default
        default:
            content.sound = .default
        }
        
        // Schedule multiple notifications (iOS limits to 64 pending notifications)
        let now = Date()
        nextAlertDate = now.addingTimeInterval(intervalSeconds)
        
        for i in 1...50 { // Schedule 50 future notifications
            let triggerDate = now.addingTimeInterval(intervalSeconds * Double(i))
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: "cathAlarm_\(i)", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification \(i): \(error)")
                }
            }
        }
    }
    
    func updateCountdown() {
        guard let nextAlert = nextAlertDate, intervalSeconds > 0 else {
            countdownText = "No alarm set"
            return
        }
        
        let now = Date()
        let timeRemaining = nextAlert.timeIntervalSince(now)
        
        if timeRemaining <= 0 {
            // Time to reschedule - move to next interval
            let newNextAlert = now.addingTimeInterval(intervalSeconds)
            nextAlertDate = newNextAlert

            // Update Live Activity with new next alarm time
            if #available(iOS 16.1, *) {
                liveActivityManager.updateLiveActivity(
                    nextAlarmTime: newNextAlert,
                    intervalText: intervalText
                )
            }

            // Play alert sound when countdown reaches zero (if permission available)
            if hasAudioPermission {
                playAlertSound()
            }

            // Recursively call to calculate the new countdown
            updateCountdown()
            return
        }
        
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        
        withAnimation(.easeInOut(duration: 0.2)) {
            countdownText = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }

        // Update Live Activity when minute changes (to keep Dynamic Island HH:MM current)
        if #available(iOS 16.1, *), seconds == 0 { // Update only when minute changes
            liveActivityManager.updateLiveActivity(
                nextAlarmTime: nextAlert,
                intervalText: intervalText
            )
        }
    }
    
    func showErrorNotification(message: String) {
        errorMessage = message
        showingErrorAlert = true
        
        // Error haptic feedback
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 MARK: - Enhanced Setup Instructions for iOS 16+
 
 1. Set minimum deployment target to iOS 16.0 in Xcode project settings
 
 2. Add the following to Info.plist:
 <key>CFBundleDisplayName</key>
 <string>Cath Now</string>
 
 <key>NSUserNotificationsUsageDescription</key>
 <string>This app needs notification permission to remind you about catheter changes when the app is not active.</string>
 
 <key>NSMicrophoneUsageDescription</key>
 <string>This app does not access the microphone. It only plays audio alerts.</string>
 
 3. IMPORTANT - Audio File Setup:
 Create a "sounds" folder in your Xcode project and add these files:
 - sounds/alarm1.wav (your first alarm sound)
 - sounds/alarm2.wav (your second alarm sound)
 
 Make sure to:
 - Add the sounds folder to your Xcode project bundle
 - Ensure the audio files are included in the app target
 - Use .wav format for best compatibility with notifications
 - Keep file sizes reasonable for app bundle size
 
 4. New Audio Features:
 - Two selectable alarm sounds: Alarm 1 and Alarm 2
 - Audio files loaded from app bundle (sounds/alarm1.wav and sounds/alarm2.wav)
 - Fallback to system sound if audio files are missing
 - Clean menu-based settings interface
 - Comprehensive privacy page
 - Professional medical app design
 
 5. UI Improvements:
 - Clean main interface focused on core functionality
 - Dropdown menu for settings and privacy access
 - Dedicated sound settings page with test functionality
 - Audio status indicators throughout the app
 - Graceful fallback to haptic feedback when audio unavailable
 
 6. Technical Features:
 - Uses AVAudioPlayer for reliable audio file playback
 - Custom notification sounds for scheduled reminders
 - Proper audio session management
 - Error handling with system sound fallbacks
 - Memory-efficient audio loading and playback
 
 The app now provides a professional medical reminder experience with custom audio files
 and a clean, organized interface suitable for medical use.
 */
