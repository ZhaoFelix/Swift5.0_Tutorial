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
            Button(action: {}) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New Scrum")
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData))
        }
    }
}
