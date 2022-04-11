//
//  ScrumsView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

// Commond + Option + P：右侧的预览快捷键
import SwiftUI

struct ScrumsView: View {
    // 定义一个绑定数据
    @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    @State private var isPresentingScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    var body: some View {
        List {
            ForEach($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    // CardView页面不需要使用绑定数据
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
        }
        .navigationTitle("Daily Scrums")
        // 导航栏上方的工具条
        .toolbar {
            Button(action: {
                isPresentingScrumView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
            .sheet(isPresented: $isPresentingScrumView) {
                NavigationView {
                    DetailEditView(data: $newScrumData)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresentingScrumView = false
                                    newScrumData = DailyScrum.Data()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Add") {
                                    let newScrum = DailyScrum(data: newScrumData)
                                    scrums.append(newScrum)
                                    isPresentingScrumView = false
                                }
                            }
                        }
                }
            }
        }
        // 当页面场景处于inactive状态时，触发数据存储事件
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}

