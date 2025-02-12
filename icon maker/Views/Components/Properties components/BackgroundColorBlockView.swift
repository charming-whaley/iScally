import SwiftUI

struct BackgroundColorBlockView: View {
    let fillColor: Color
    
    init(_ fillColor: Color) {
        self.fillColor = fillColor
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(fillColor.gradient)
            .frame(height: 130)
            .frame(maxWidth: .infinity)
    }
}
