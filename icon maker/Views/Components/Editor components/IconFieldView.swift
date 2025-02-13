import SwiftUI

public struct IconFieldView: View {
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
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 60)
            .fill(hasGradient ? AnyShapeStyle(backgroundColor.gradient) : AnyShapeStyle(backgroundColor))
            .frame(width: 300, height: 300)
            .overlay(alignment: .center) {
                if !imageName.isEmpty {
                    Image(systemName: imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .foregroundStyle(imageColor)
                }
            }
            .padding()
            .shadow(color: backgroundColor.opacity(hasShadow ? 0.4 : 0), radius: 5, x: 5, y: 5)
            .shadow(color: backgroundColor.opacity(hasShadow ? 0.4 : 0), radius: 5, x: -5, y: -5)
    }
}
