//
//  Theme.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/6.
//

import Foundation
import SwiftUI

enum Theme: String {
    case bubblegum
    case buttoncup
    case indigo
    case lavender
    case navy
    case magenta
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttoncup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow:
            return .black
        case .indigo, .magenta, .navy, .oxblood, .purple:
            return .white
        }
    }
    /// 使用枚举的`rawValue`创建mainColor属性
    var mainColor: Color {
        Color(rawValue)
    }
}
