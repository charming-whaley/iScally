import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published
    var hasGradient = false
    @Published 
    var customColor = ""
    @Published
    var originalColor: Color = Contents.backgroundColors.first!.customColor
    @Published
    var currentSymbol: String = Contents.icons.first!
    @Published
    var symbolColor: Color = .white
    @Published 
    var filename: String = String(localized: "properties.thirdSection.field.originalName")
    @Published
    var hasWatchOSSupport: Bool = false
    @Published
    var hasMacOSSupport: Bool = false
    @Published
    var customColorTint: Color = .yellow
}
