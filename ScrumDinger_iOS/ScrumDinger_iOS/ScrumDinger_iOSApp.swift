//
//  ScrumDinger_iOSApp.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import SwiftUI

@main
struct ScrumDinger_iOSApp: App {
    // 定义一个状态数据
    //@State private var scrums = DailyScrum.sampleData
    @StateObject private var store = ScrumStore()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    ScrumStore.save(scrums: store.scrums) { result in
                        // TODO: todo
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                ScrumStore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let scrums):
                        store.scrums = scrums
                    }
                }
            }
        }
    }
}
