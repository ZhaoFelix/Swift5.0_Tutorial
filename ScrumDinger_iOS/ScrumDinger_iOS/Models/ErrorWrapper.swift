//
//  ErrorWrapper.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/11.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
    
}
