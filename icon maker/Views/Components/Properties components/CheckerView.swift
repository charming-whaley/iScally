import SwiftUI

public struct CheckerView: View {
    @Binding
    var switcher: Bool
    
    let title: String
    
    public var body: some View {
        HStack(spacing: 10) {
            Image(systemName: switcher ? "checkmark.square.fill" : "square")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
                .foregroundStyle(switcher ? .yellow : .white)
            
            Text(title)
                .font(.system(size: 14))
        }
        .onTapGesture {
            switcher.toggle()
        }
    }
}
