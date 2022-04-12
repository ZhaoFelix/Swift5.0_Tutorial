//
//  History.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/11.
//

import SwiftUI
import Foundation

struct History:Identifiable, Codable {
    let id:UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lengthInMinutes: Int
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], lengthInMinutes: Int = 5, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
    
}


extension History {
    // 将与会者数组信息格式化为易读的字符串格式
    var attendeesString: String {
        ListFormatter.localizedString(byJoining: attendees.map{ $0.name })
    }
}
