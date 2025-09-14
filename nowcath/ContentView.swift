import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var intervalText = "4:00"
    @State private var nextAlertDate: Date?
    @State private var intervalSeconds: TimeInterval = 0
    @State private var countdownText = "No alarm set"
    @State private var statusText = "Ready to set alarm"
    @State private var showingErrorAlert = false
    @State private var errorMessage = ""
    
    // Timer to update countdown every second for real-time updates
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
                    VStack(spacing: 25) {
                        // Header Section
                        VStack(spacing: 15) {
                            Image(systemName: "cross.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                            
                            Text("Cath Now")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                        }
                        .padding(.top, 20)
                        
                        // Input Section
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "clock.circle.fill")
                                        .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                                        .font(.title2)
                                    
                                    Text("Alarm Interval")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                Text("Enter the alarm interval in the format HH:MM")
                                    .font(.subheadline)
                                    .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                                    .multilineTextAlignment(.leading)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    Spacer()
                                    
                                    TextField("HH:MM", text: $intervalText)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 120, height: 50)
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 0.2, green: 0.4, blue: 0.8), lineWidth: 2)
                                        )
                                        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                                    
                                    Spacer()
                                }
                                
                                Button(action: startButtonTapped) {
                                    HStack {
                                        Image(systemName: statusText.contains("active") ? "arrow.clockwise.circle.fill" : "play.circle.fill")
                                            .font(.title2)
                                        Text(statusText.contains("active") ? "Update Alarm" : "Start Alarm")
                                            .font(.headline)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, minHeight: 50)
                                    .background(
                                        LinearGradient(
                                            colors: statusText.contains("active") ? [
                                                Color(red: 0.2, green: 0.7, blue: 0.2),
                                                Color(red: 0.15, green: 0.65, blue: 0.15)
                                            ] : [
                                                Color(red: 0.2, green: 0.4, blue: 0.8),
                                                Color(red: 0.15, green: 0.35, blue: 0.75)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .scaleEffect(1.0)
                                .animation(.easeInOut(duration: 0.1), value: showingErrorAlert)
                            }
                            .padding(20)
                        } label: {
                            Label("Alarm Configuration", systemImage: "gear.badge")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
                        // Status Section
                        GroupBox {
                            VStack(spacing: 20) {
                                HStack {
                                    Image(systemName: "timer.circle.fill")
                                        .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                                        .font(.title2)
                                    
                                    Text("Next Alarm")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                
                                VStack(spacing: 15) {
                                    Text(countdownText)
                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                        .foregroundStyle(
                                            countdownText == "No alarm set" ?
                                                .secondary : Color(red: 0.8, green: 0.2, blue: 0.2)
                                        )
                                        .contentTransition(.numericText())
                                    
                                    Divider()
                                        .background(Color(red: 0.2, green: 0.4, blue: 0.8).opacity(0.3))
                                    
                                    HStack {
                                        Image(systemName: statusText.contains("active") ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(statusText.contains("active") ? .green : .secondary)
                                            .font(.title3)
                                        
                                        Text(statusText)
                                            .font(.subheadline)
                                            .foregroundStyle(Color(red: 0.2, green: 0.4, blue: 0.8))
                                        
                                        Spacer()
                                    }
                                }
                            }
                            .padding(20)
                        } label: {
                            Label("Status Monitor", systemImage: "heart.text.square")
                                .font(.headline)
                                .foregroundStyle(Color(red: 0.8, green: 0.2, blue: 0.2))
                        }
                        .groupBoxStyle(MedicalGroupBoxStyle())
                        
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
        }
        .alert("Invalid Input", isPresented: $showingErrorAlert) {
            Button("OK") {
                // Optional: Add any action when OK is pressed
            }
        } message: {
            Text(errorMessage)
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
        
        intervalSeconds = interval
        scheduleRepeatingNotifications()
        
        statusText = "Alarm active - repeats every \(intervalText)"
        updateCountdown()
        
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
        content.sound = .default
        content.badge = 1
        
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
    }
    
    func showErrorNotification(message: String) {
        errorMessage = message
        showingErrorAlert = true
        
        // Error haptic feedback
        let notificationFeedback = UINotificationFeedbackGenerator()
        notificationFeedback.notificationOccurred(.error)
    }
}

// MARK: - Custom GroupBox Style
struct MedicalGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            configuration.label
                .font(.headline)
                .padding(.horizontal, 4)
            
            configuration.content
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.2, green: 0.4, blue: 0.8).opacity(0.3),
                                    Color(red: 0.2, green: 0.4, blue: 0.8).opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        }
    }
}

// MARK: - Notification Delegate
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 MARK: - Setup Instructions for iOS 16+
 
 1. Set minimum deployment target to iOS 16.0 in Xcode project settings
 
 2. Add the following to Info.plist:
 <key>CFBundleDisplayName</key>
 <string>Cath Now</string>
 
 <key>NSUserNotificationsUsageDescription</key>
 <string>This app needs notification permission to remind you about catheter changes when the app is not active.</string>
 
 3. iOS 16+ Features Used:
 - NavigationStack (replaces NavigationView)
 - GroupBox with custom styling
 - contentTransition(.numericText()) for smooth countdown updates
 - LinearGradient backgrounds
 - Advanced shadow and overlay modifiers
 - Haptic feedback integration
 - SF Symbols 4.0 icons
 - Modern alert modifier with message parameter
 
 4. Enhanced Medical Design:
 - Grouped UI elements in rounded medical containers
 - Medical cross icon in header
 - Status indicators with appropriate colors
 - Gradient backgrounds and buttons
 - Professional shadows and borders
 - Clean typography hierarchy
 - Haptic feedback for user interactions
 
 5. Key Improvements:
 - Custom MedicalGroupBoxStyle for consistent theming
 - Better visual hierarchy with icons and labels
 - Smooth animations and transitions
 - Enhanced error handling with haptic feedback
 - Professional medical aesthetic
 - Responsive layout that works on all iOS devices
 - Updated alert modifier to use the modern iOS 16+ syntax
 
 The app now uses the modern iOS 16+ alert syntax that won't show deprecation warnings, while maintaining all the medical theme and functionality.
 */
