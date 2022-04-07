//
//  ScrumDinger_iOSApp.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import SwiftUI

@main
struct ScrumDinger_iOSApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
