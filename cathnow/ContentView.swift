import SwiftUI
import UserNotifications


struct ContentView: View {
    @State private var intervalText = "4:00"
    @State private var isActive = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var nextAlarmDate: Date?
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Medical gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.94, green: 0.96, blue: 0.98),
                        Color(red: 0.88, green: 0.94, blue: 0.96)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "cross.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.8))
                        
                        Text("Cath Now")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.5))
                        
                        Text("Catheter Reminder System")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 0.4, green: 0.5, blue: 0.6))
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Main content card
                    VStack(spacing: 25) {
                        VStack(spacing: 12) {
                            Text("Enter the alarm interval in the format HH:MM")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color(red: 0.2, green: 0.3, blue: 0.4))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            // Status indicator
                            HStack {
                                Circle()
                                    .fill(isActive ? Color.green : Color.gray)
                                    .frame(width: 12, height: 12)
                                
                                Text(isActive ? "Active" : "Inactive")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(isActive ? Color.green : Color.gray)
                            }
                        }
                        
                        // Input field
                        VStack(spacing: 8) {
                            Text("Interval")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(red: 0.3, green: 0.4, blue: 0.5))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("4:00", text: $intervalText)
                                .font(.system(size: 24, weight: .medium, design: .monospaced))
                                .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.5))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color(red: 0.7, green: 0.8, blue: 0.9), lineWidth: 2)
                                )
                                .cornerRadius(12)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(.horizontal, 20)
                        
                        // Start button
                        Button(action: startAlarms) {
                            HStack(spacing: 12) {
                                Image(systemName: "alarm.fill")
                                    .font(.system(size: 18, weight: .semibold))
                                
                                Text("Start")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.2, green: 0.6, blue: 0.8),
                                        Color(red: 0.1, green: 0.5, blue: 0.7)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color(red: 0.2, green: 0.6, blue: 0.8).opacity(0.3), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 20)
                        
                        // Next alarm countdown
                        if isActive, let nextAlarm = nextAlarmDate {
                            VStack(spacing: 8) {
                                Text("Time Until Next Reminder")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(Color(red: 0.5, green: 0.6, blue: 0.7))
                                
                                HStack(spacing: 16) {
                                    let countdown = getCountdownComponents(to: nextAlarm)
                                    
                                    CountdownComponent(value: countdown.hours, label: "Hours")
                                    CountdownComponent(value: countdown.minutes, label: "Minutes")
                                    CountdownComponent(value: countdown.seconds, label: "Seconds")
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color(red: 0.95, green: 0.98, blue: 1.0),
                                        Color(red: 0.90, green: 0.95, blue: 0.98)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(red: 0.2, green: 0.6, blue: 0.8).opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: Color(red: 0.2, green: 0.6, blue: 0.8).opacity(0.1), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    // Footer
                    Text("Copyright © 2025 White Acre Software LLC. All rights reserved.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(red: 0.5, green: 0.6, blue: 0.7))
                        .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("Notification", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if !granted {
                DispatchQueue.main.async {
                    self.alertMessage = "Please enable notifications in Settings to receive catheter reminders."
                    self.showAlert = true
                }
            }
        }
    }
    
    func startAlarms() {
        // Cancel all existing notifications and timer
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        timer?.invalidate()
        
        // Validate input format
        guard isValidTimeFormat(intervalText) else {
            alertMessage = "Please enter time in HH:MM format (e.g., 4:00)"
            showAlert = true
            return
        }
        
        // Parse the interval
        let components = intervalText.split(separator: ":")
        guard components.count == 2,
              let hours = Int(components[0]),
              let minutes = Int(components[1]),
              hours >= 0, hours <= 23,
              minutes >= 0, minutes <= 59 else {
            alertMessage = "Invalid time format. Please use HH:MM (e.g., 4:00)"
            showAlert = true
            return
        }
        
        let intervalInSeconds = TimeInterval((hours * 3600) + (minutes * 60))
        
        // Minimum interval check (prevent too frequent notifications)
        if intervalInSeconds < 300 { // 5 minutes minimum
            alertMessage = "Minimum interval is 5 minutes for safety."
            showAlert = true
            return
        }
        
        // Set next alarm date and start timer
        nextAlarmDate = Date().addingTimeInterval(intervalInSeconds)
        startCountdownTimer(interval: intervalInSeconds)
        
        // Schedule repeating notifications
        scheduleRepeatingNotifications(interval: intervalInSeconds)
        
        isActive = true
        alertMessage = "Catheter reminders started! You'll receive notifications every \(intervalText)."
        showAlert = true
    }
    
    
    func startCountdownTimer(interval: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            guard let nextAlarm = nextAlarmDate else { return }
            
            // Check if alarm time has passed
            if Date() >= nextAlarm {
                // Update to next alarm time
                nextAlarmDate = nextAlarm.addingTimeInterval(interval)
            }
        }
    }
    
    func getCountdownComponents(to date: Date) -> (hours: Int, minutes: Int, seconds: Int) {
        let timeInterval = max(0, date.timeIntervalSinceNow)
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) % 3600 / 60
        let seconds = Int(timeInterval) % 60
        return (hours, minutes, seconds)
    }
    
    func scheduleRepeatingNotifications(interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Cath Now Reminder"
        content.body = "Time to cath!"
        content.sound = .default
        content.badge = 1
        
        // Schedule multiple notifications (iOS limitation workaround)
        // Schedule up to 64 notifications (iOS limit)
        for i in 1...60 {
            let triggerTime = interval * Double(i)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: "cathReminder_\(i)",
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }
    
    func isValidTimeFormat(_ time: String) -> Bool {
        let pattern = "^([0-9]|[01][0-9]|2[0-3]):([0-5][0-9])$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: time.utf16.count)
        return regex?.firstMatch(in: time, options: [], range: range) != nil
    }
    
    func getNextAlarmTime() -> String {
        guard let nextAlarm = nextAlarmDate else { return "Not set" }
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        
        return formatter.string(from: nextAlarm)
    }
}

struct CountdownComponent: View {
    let value: Int
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.system(size: 28, weight: .bold, design: .monospaced))
                .foregroundColor(Color(red: 0.2, green: 0.6, blue: 0.8))
                .frame(width: 60, height: 40)
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 0.8, green: 0.9, blue: 0.95), lineWidth: 1)
                )
            
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(red: 0.5, green: 0.6, blue: 0.7))
        }
    }
}

#Preview {
    ContentView()
}
