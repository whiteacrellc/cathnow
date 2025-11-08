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
import AVFoundation

@MainActor
class AudioManager: ObservableObject {
    static let shared = AudioManager()
    @Published var isAudioSessionActive = false

    private init() {}

    /// Sets up audio session for playback only (no microphone permission needed)
    func setupAudioSession() -> Bool {
        do {
            // Set category to playback only - no microphone access needed
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.allowBluetooth])
            try AVAudioSession.sharedInstance().setActive(true)
            isAudioSessionActive = true
            return true
        } catch {
            print("❌ Failed to set up audio session: \(error)")
            isAudioSessionActive = false
            return false
        }
    }

    /// Deactivates audio session when no longer needed
    func deactivateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            isAudioSessionActive = false
        } catch {
            print("⚠️ Failed to deactivate audio session: \(error)")
        }
    }
}
