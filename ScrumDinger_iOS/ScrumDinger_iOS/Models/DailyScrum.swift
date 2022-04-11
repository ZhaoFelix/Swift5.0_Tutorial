//
//  DailyScrum.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import Foundation

/// 数据模型
struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    init(id: UUID = UUID(), title: String, attendees: [Attendee], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes:Double(lengthInMinutes), theme: theme)
    }
    // 更新数据
    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }
    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        theme = data.theme
        lengthInMinutes = Int(data.lengthInMinutes)
    }
    
}

// 增加测试数据
extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design", attendees: [Attendee(name: "Cathy"), Attendee(name: "Daisy") ,Attendee(name: "Simon"), Attendee(name: "Jonathan")], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: [Attendee(name:"Katie"), Attendee(name:  "Euna"), Attendee(name:"Luis"),  Attendee(name: "Darla")], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Deb", attendees: [Attendee(name:"Chella"), Attendee(name:"Chris"), Attendee(name:"Christina"), Attendee(name:"Eden"), Attendee(name:"Karla"), Attendee(name:"Lindsey"), Attendee(name:"Aga"), Attendee(name:"Chad"), Attendee(name:"Jenn"), Attendee(name:"Sarah")], lengthInMinutes: 5, theme: .poppy)
    ]
}
