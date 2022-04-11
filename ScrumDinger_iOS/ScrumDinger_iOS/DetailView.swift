//
//  DetailView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var isPresentingEditView = false
    @State private var data = DailyScrum.Data()
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .ignore)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
                Section(header: Text("Attendees")) {
                    ForEach(scrum.attendees) { attendee in
                        Label(attendee.name, systemImage: "person")
                    }
                }
                
            }
        }
        .navigationTitle(scrum.title)
        .toolbar(content: {
            Button("Edit") {
                isPresentingEditView = true
                data = scrum.data
            }
        })
        // 底部从下而上的页面弹出
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                 // 顶部工具条
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancle") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                 // 更新数据
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
