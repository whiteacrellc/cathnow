import SwiftUI
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    func requestAudioPermission(completion: @escaping (Bool) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers])
                        try AVAudioSession.sharedInstance().setActive(true)
                    } catch {
                        print("Audio session setup failed: \(error)")
                        completion(false)
                        return
                    }
                }
                completion(granted)
            }
        }
    }
}
