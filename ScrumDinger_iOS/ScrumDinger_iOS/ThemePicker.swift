//
//  ThemePicker.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//

import SwiftUI
// 主题选择器
struct ThemePicker: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) {theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
   
    static var previews: some View {
        // 传递一个常量绑定
        ThemePicker(selection: .constant(.periwinkle))
    }
}
