import SwiftUI

public struct ZoomInOutView: View {
    @Binding
    var scale: CGFloat
    @State
    private var minimumScale: CGFloat = 1.0
    @State
    private var maximumScale: CGFloat = 1.7
    
    public var body: some View {
        HStack(spacing: 10) {
            Button {
                scale = min(maximumScale, scale + 0.1)
            } label: {
                Image(systemName: "plus.magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.yellow)
                    }
            }
            .buttonStyle(.plain)
            
            Button {
                scale = max(minimumScale, scale - 0.1)
            } label: {
                Image(systemName: "minus.magnifyingglass")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .fontWeight(.heavy)
                    .frame(width: 60, height: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.yellow)
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ZoomInOutView(scale: .constant(1.0))
}
