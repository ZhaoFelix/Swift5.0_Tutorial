//
//  ScrumDinger_iOSApp.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import SwiftUI
/*
  获取APP的文件沙盒路径
   终端运行如下命令：
   xcrun simctl get_app_container booted APP的budle Id data
   xcrun simctl get_app_container booted www.swift.bedeveloper.cn.ScrumDinger data
 
  获取的路径如下：
  /Users/felix/Library/Developer/CoreSimulator/Devices/214F3BED-A2ED-4C36-B5F7-BE5928421D5B/data/Containers/Data/Application/0A189305-C2F2-4828-A36E-FFBB0359C291
 
   在Finder中打开文件路径：
    open -a Finder 文件路径
 */
@main
struct ScrumDinger_iOSApp: App {
    // 定义一个状态数据
    //@State private var scrums = DailyScrum.sampleData
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
//                    ScrumStore.save(scrums: store.scrums) { result in
//                        // TODO: todo
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            // fatalError("Error saving scrums")
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
//            .onAppear {
//                ScrumStore.load { result in
//                    switch result {
//                    case .failure(let error):
//                        fatalError(error.localizedDescription)
//                    case .success(let scrums):
//                        store.scrums = scrums
//                    }
//                }
//            }
            .task {
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    //fatalError("Error loading scrums.")
                    errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                }
            }
            .sheet(item: $errorWrapper) {
                // 当错误发生时，用户点击dismiss后加载样例数据
                store.scrums = DailyScrum.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }

        }
    }
}
