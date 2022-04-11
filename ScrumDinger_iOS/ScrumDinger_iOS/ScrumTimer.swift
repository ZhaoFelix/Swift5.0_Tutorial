//
//  ScrumTimer.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//

import Foundation

class ScrumTimer: ObservableObject {
    // 说话者的信息
    struct Speaker: Identifiable {
        let name: String
        // 是否已结束说话
        var isCompleted: Bool
        let id: UUID = UUID()
    }
    /// 正在说话者的名字
    @Published var activeSpeaker = ""
    /// 会议的持续时长
    @Published var secondsElapsed = 0
    /// 剩余时间
    @Published var secondsRemaining = 0
    /// 所有的与会者信息，按说话顺序排序
    private(set) var speakers: [Speaker] = []
    /// 会议时长
    private(set) var lengthInMinutes: Int
    
    var speakerChangedAction: (() -> Void)?
    
    private var timer: Timer?
    private var timerStopped = false
    private var frequency: TimeInterval { 1.0 / 60.0}
    private var lenghtInSeconds: Int { lengthInMinutes * 60}
    private var secondsPerSpeaker: Int {
        (lengthInMinutes * 60) / speakers.count
    }
    
    private var secondsElapsedForSpeaker: Int = 0
    private var speakerIndex: Int = 0
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    private var startDate: Date?
    
    init(lengthInMinutes: Int = 0, attendes:[DailyScrum.Attendee] = []) {
        self.lengthInMinutes = lengthInMinutes
        self.speakers = attendes.speakers
        secondsRemaining = lenghtInSeconds
        activeSpeaker = speakerText
    }
    
    func startScrum(){
        changeToSpeaker(at: 0)
    }
    
    func stopScrum(){
        timer?.invalidate()
        timer = nil
        timerStopped = true
    }
    
    private func changeToSpeaker(at index: Int) {
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        secondsElapsedForSpeaker = 0
        guard index < speakers.count else {return}
        speakerIndex = index
        activeSpeaker = speakerText
        
        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = lenghtInSeconds - secondsElapsed
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
            if let self = self, let startDate = self.startDate {
                let secondsElapsed = Date().timeIntervalSince1970 - startDate.timeIntervalSince1970
                self.update(secondsElapsed: Int(secondsElapsed))
                
            }
        }
    }
    
    private func update(secondsElapsed: Int) {
        secondsElapsedForSpeaker = secondsElapsed
        self.secondsElapsed = secondsPerSpeaker * speakerIndex + secondsElapsedForSpeaker
        
        guard secondsElapsed <= secondsPerSpeaker else {
            return
        }
        secondsRemaining = max(lenghtInSeconds - self.secondsElapsed, 0)
        if secondsElapsedForSpeaker >= secondsPerSpeaker {
            changeToSpeaker(at: speakerIndex + 1)
            speakerChangedAction?()
        }
    }
    
    func reset(lenghtInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.lengthInMinutes = lenghtInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = lenghtInSeconds
        activeSpeaker = speakerText
    }
}

/// 扩张数组
extension Array where Element == DailyScrum.Attendee {
    var speakers: [ScrumTimer.Speaker] {
        if isEmpty {
            return [ScrumTimer.Speaker(name: "Spaker 1", isCompleted: false)]
        } else {
            return map{
                ScrumTimer.Speaker(name: $0.name, isCompleted: false)
            }
        }
    }
}

