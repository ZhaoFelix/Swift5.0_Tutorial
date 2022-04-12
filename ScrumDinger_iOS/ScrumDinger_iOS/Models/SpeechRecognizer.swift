//
//  SpeechRecognizer.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/11.
//

import Foundation
import AVFoundation
import SwiftUI
import Speech

class SpeechRecognizer: ObservableObject {
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavaiable
        
        var message: String {
            switch self {
            case .nilRecognizer:
                return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize:
                return "Not authorized to speech"
            case .notPermittedToRecord:
                return "Not permitted to record audio"
            case .recognizerIsUnavaiable:
                return "Recognizer is unavailable"
            }
        }
    }
    
    @Published var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    init() {
        recognizer = SFSpeechRecognizer()
        Task(priority: .background) {
            do {
                guard recognizer != nil else {
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    throw RecognizerError.notPermittedToRecord
                }
            }
            catch {
                speakError(error)
            }
        }
    }
    deinit {
        reset()
    }
    
    // -TODO:todo
    func transcribe() {
        DispatchQueue(label: "Speeck Recogninzer Queue", qos: .background).async {
            [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavaiable)
                return
            }
            do {
                let (audioEngine, request) = try Self.prepareEngine()
                self.audioEngine = audioEngine
                self.request = request
                
                self.task = recognizer.recognitionTask(with: request) {
                    result, error in
                    let receivedFinalResult = result?.isFinal ?? false
                    let receivedError = error != nil
                    if receivedFinalResult || receivedError {
                        audioEngine.stop()
                        audioEngine.inputNode.removeTap(onBus: 0)
                    }
                    if let result = result {
                        self.speak(result.bestTranscription.formattedString)
                    }
                }
            } catch {
                self.reset()
                self.speakError(error)
            }
        }
        
    }
    
    func stopTranscribing() {
        reset()
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        try audioEngine.start()
        return (audioEngine, request)
    }
    
    func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    func speak(_ message: String) {
        transcript = message
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        }
        else {
            errorMessage += error.localizedDescription
        }
        transcript = "<< \(errorMessage) >>"
    }
}


extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation{ continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}


extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation{ continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
