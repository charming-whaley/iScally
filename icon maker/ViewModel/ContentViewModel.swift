import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published
    var title: String = "New Icon"
    @Published
    var width: CGFloat = .zero
    @Published
    var height: CGFloat = .zero
    @Published
    var systemImage: String = ""
    @Published
    var backgroundColor: Color = .blue
    @Published
    var hasGradient: Bool = false
    @Published
    var hasInnerShadow: Bool = false
}
