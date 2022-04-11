//
//  ScrumProgressViewStyle.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(theme.accentColor)
                .frame(height: 10)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 12)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12)
                    .padding(.horizontal)
            }
        }
    }
}

struct ScrumProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 4.0)
            .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
        // 预览布局适应视图大小
            .previewLayout(.sizeThatFits)
    }
}

