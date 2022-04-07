//
//  ThemeView.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.mainColor)
            Label(theme.name, systemImage: "paintpalette")
                .padding(4)
        }
        .foregroundColor(theme.accentColor)
        // 水平填充，垂直方向自适应
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ThemeView_Previews: PreviewProvider {
    static let theme: Theme = Theme.orange
    static var previews: some View {
        ThemeView(theme: theme)
    }
}
