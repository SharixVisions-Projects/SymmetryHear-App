//
//  SoundGenerator.swift
//  EarSpectrum
//
//  Created by Unique Consulting Firm on 22/05/2024.
//

import AVFoundation


class SoundGenerator {
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var audioFormat: AVAudioFormat!
    
    init() {
        audioEngine = AVAudioEngine()
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        let sampleRate: Double = 44100.0
        let channels: AVAudioChannelCount = 1
        audioFormat = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: channels)
        
        audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: audioFormat)
        
        try! audioEngine.start()
    }
    
    func playFrequency(frequency: Double) {
        let sampleRate = audioFormat.sampleRate
        let length = AVAudioFrameCount(sampleRate)
        let buffer = AVAudioPCMBuffer(pcmFormat: audioFormat, frameCapacity: length)!
        buffer.frameLength = length
        
        let theta = 2.0 * Double.pi * frequency / sampleRate
        let amplitude: Float = 0.25
        for frame in 0..<Int(length) {
            buffer.floatChannelData?.pointee[frame] = amplitude * sin(Float(theta * Double(frame)))
        }
        
        audioPlayerNode.stop()
        audioPlayerNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
        audioPlayerNode.play()
    }
    
    func stop() {
        audioPlayerNode.stop()
    }
}
