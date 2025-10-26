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

