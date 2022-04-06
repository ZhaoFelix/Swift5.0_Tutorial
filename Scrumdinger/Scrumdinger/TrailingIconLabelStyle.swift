//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by FelixZhao on 2022/4/6.
//

// 自定义右侧图标文字样式
import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var tarilingIcon: Self { Self() }
}

