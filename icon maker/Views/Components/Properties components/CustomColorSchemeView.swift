import SwiftUI

public struct CustomColorSchemeView: View {
    @Binding
    var colorScheme: Color
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Contents.standardColorSchemes) { scheme in
                Rectangle()
                    .fill(scheme.customColor)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            colorScheme = scheme.customColor
                        }
                    }
                    .overlay {
                        if colorScheme == scheme.customColor,
                           colorScheme != Contents.standardColorSchemes.first!.customColor,
                           colorScheme != Contents.standardColorSchemes.last!.customColor
                        {
                            Rectangle()
                                .fill(.clear)
                                .stroke(.white, lineWidth: 4)
                        }
                        
                        if colorScheme == scheme.customColor,
                           colorScheme == Contents.standardColorSchemes.first!.customColor,
                           colorScheme != Contents.standardColorSchemes.last!.customColor
                        {
                            CustomRoundedRectangle(topLeftRadius: 10, bottomLeftRadius: 10)
                                .fill(.clear)
                                .stroke(.white, lineWidth: 4)
                        }
                        
                        if colorScheme == scheme.customColor,
                           colorScheme != Contents.standardColorSchemes.first!.customColor,
                           colorScheme == Contents.standardColorSchemes.last!.customColor
                        {
                            CustomRoundedRectangle(topRightRadius: 10, bottomRightRadius: 10)
                                .fill(.clear)
                                .stroke(.white, lineWidth: 4)
                        }
                    }
            }
        }
        .clipShape(.rect(cornerRadius: 10))
        .frame(height: 30)
        .frame(maxWidth: .infinity)
    }
    
    private struct CustomRoundedRectangle: Shape {
        var topLeftRadius: CGFloat = 0
        var topRightRadius: CGFloat = 0
        var bottomLeftRadius: CGFloat = 0
        var bottomRightRadius: CGFloat = 0
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            
            path.move(to: CGPoint(x: width - topRightRadius, y: 0))
            path.addArc(
                center: CGPoint(x: width - topRightRadius, y: topRightRadius),
                radius: topRightRadius,
                startAngle: .degrees(-90),
                endAngle: .degrees(0),
                clockwise: false
            )
            
            path.addLine(to: CGPoint(x: width, y: height - bottomRightRadius))
            path.addArc(
                center: CGPoint(x: width - bottomRightRadius, y: height - bottomRightRadius),
                radius: bottomRightRadius,
                startAngle: .degrees(0),
                endAngle: .degrees(90),
                clockwise: false
            )
            
            path.addLine(to: CGPoint(x: bottomLeftRadius, y: height))
            path.addArc(
                center: CGPoint(x: bottomLeftRadius, y: height - bottomLeftRadius),
                radius: bottomLeftRadius,
                startAngle: .degrees(90),
                endAngle: .degrees(180),
                clockwise: false
            )
            
            path.addLine(to: CGPoint(x: 0, y: topLeftRadius))
            path.addArc(
                center: CGPoint(x: topLeftRadius, y: topLeftRadius),
                radius: topLeftRadius,
                startAngle: .degrees(180),
                endAngle: .degrees(270),
                clockwise: false
            )
            
            path.closeSubpath()
            return path
        }
    }
}
