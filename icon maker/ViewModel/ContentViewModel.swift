import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published
    var hasGradient = false
    @Published 
    var customColor = ""
    @Published
    var originalColor: Color = Constants.backgroundColors.first!
    @Published
    var currentSymbol: String = Constants.icons.first!
    @Published
    var symbolColor: Color = .white
    @Published 
    var filename: String = "New image"
    @Published
    var hasWatchOSSupport: Bool = false
    @Published
    var hasHigherQuality: Bool = false
    @Published
    var archiveImages: Bool = false
}
