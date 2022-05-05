//
//  MeetingHeaderView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsReamaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsReamaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1}
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemain: Int {
        secondsReamaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Second Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.bottomhalf.fill")
                }
                Spacer()
                VStack {
                    Text("Second Remaining")
                        .font(.caption)
                    Label("\(secondsReamaining)", systemImage: "hourglass.tophalf.fill")
                        .labelStyle(.tarilingIcon)
                }
            }
        }
        // -TODO: 辅助功能
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemain) minutes")
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingHeaderView(secondsElapsed: 70, secondsReamaining: 70, theme: .orange)
            
        }
}
