//
//  AVPlayer+Ding.swift
//  ScrumDinger_iOS
//
//  Created by FelixZhao on 2022/4/7.
//
import Foundation
import AVFoundation
extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }()
}
