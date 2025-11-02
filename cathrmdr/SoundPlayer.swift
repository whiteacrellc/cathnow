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

class SoundPlayer {
    static let shared = SoundPlayer()
    private var player: AVAudioPlayer?
    
    func play(soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("❌ Could not find \(soundName).wav in bundle")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
            print("▶️ Playing \(soundName).wav")
        } catch {
            print("❌ Failed to play \(soundName).wav: \(error)")
        }
    }
}

