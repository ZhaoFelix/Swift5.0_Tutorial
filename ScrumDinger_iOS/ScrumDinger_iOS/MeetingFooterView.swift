//
//  MeetingFooterView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/11.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipSction: () -> Void
    
    private var speakerNumber: Int? {
        // 获取第一个未讲的index
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else {
            return nil
        }
        return index + 1
    }
    /// 是否是最后一个说话者
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else {
            return "No more speakers"
        }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack{
                if isLastSpeaker {
                   Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipSction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

