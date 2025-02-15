import SwiftUI

public struct Constants {
    static let backgroundColors: [Color] = [
        .red, .green, .blue, .yellow, .pink, .purple, .orange, .cyan, .mint, .teal
    ]
    
    static let icons: [String] = [
        "sun.max.fill", "moon.fill", "sparkles", "moon.stars.fill", "microphone.fill", "message.fill", "quote.bubble.fill", "phone.fill",
        "video.fill", "envelope.fill", "map.fill", "figure.walk.triangle.fill", "tram.fill", "fuelpump.fill", "binoculars.fill", "display.2",
        "macbook.and.iphone", "vision.pro.fill", "homepod.mini.2.fill", "gamecontroller.fill", "car.2.fill", "music.note.tv.fill", "car.fill", "camera.fill",
        "camera.macro", "photo.fill", "flag.pattern.checkered.2.crossed", "icloud.fill", "wifi", "bonjour", "fan.fill", "globe.americas.fill",
        "drop.circle.fill", "hare.fill", "tortoise.fill", "bird.fill", "leaf.fill", "tree.fill", "atom", "heart.fill",
        "cross.fill", "pills.fill", "brain.head.profile.fill", "waveform.path.ecg.rectangle.fill", "compass.drawing", "function", "apple.intelligence", "apple.terminal.fill"
    ]
    
    static let columns = Array(repeating: GridItem(.fixed(130), spacing: 15), count: 2)
    
    static let imageSizes: [ImageSize] = [
        .init(width: 40, height: 40),
        .init(width: 58, height: 58),
        .init(width: 60, height: 60),
        .init(width: 76, height: 76),
        .init(width: 80, height: 80),
        .init(width: 87, height: 87),
        .init(width: 114, height: 114),
        .init(width: 120, height: 120),
        .init(width: 128, height: 128),
        .init(width: 136, height: 136),
        .init(width: 167, height: 167),
        .init(width: 180, height: 180),
        .init(width: 192, height: 192),
        .init(width: 1024, height: 1024)
    ]
}
