import SwiftUI
import AppKit

public struct FieldView: View {
    @Binding
    var backgroundColor: Color
    @Binding
    var hasGradient: Bool
    @Binding
    var imageName: String
    @Binding
    var imageColor: Color
    @Binding
    var hasShadow: Bool
    
    var width: CGFloat = 300
    var height: CGFloat = 300
    var radius: CGFloat = 60
    
    public var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .fill(hasGradient ? AnyShapeStyle(backgroundColor.gradient) : AnyShapeStyle(backgroundColor))
            .frame(width: width, height: height)
            .overlay(alignment: .center) {
                if !imageName.isEmpty {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width / 2, height: height / 2)
                        .foregroundStyle(imageColor)
                }
            }
            .padding()
            .shadow(color: backgroundColor.opacity(hasShadow ? 0.4 : 0), radius: 5, x: 5, y: 5)
            .shadow(color: backgroundColor.opacity(hasShadow ? 0.4 : 0), radius: 5, x: -5, y: -5)
    }
}
