import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published
    var hasGradient = false
    @Published 
    var customColor = ""
    @Published
    var originalColor: Color = Contents.backgroundColors.first!
    @Published
    var currentSymbol: String = Contents.icons.first!
    @Published
    var symbolColor: Color = .white
    @Published 
    var filename: String = "New image"
    @Published
    var hasWatchOSSupport: Bool = false
    @Published
    var hasMacOSSupport: Bool = false
}
