//
//  ContentView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//


import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsReamaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                // -TODO:2
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipSction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        // 生命周期事件，每次页面出现是重置计时器
        .onAppear{
            scrumTimer.reset(lenghtInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction =  {
                player.seek(to: .zero)
                player.play()
            }
            //  开始一个新的计时器
            scrumTimer.startScrum()
        }
        // 页面消失时停止计时器
        .onDisappear {
            scrumTimer.stopScrum()
            // 页面小消失后，添加历史记录
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
            
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
           
    }
}
