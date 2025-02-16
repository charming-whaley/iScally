import SwiftUI
import AppKit

public struct RootView: View {
    @StateObject
    var contentViewModel = ContentViewModel()
    
    let windowFrame: CGFloat = (NSScreen.main?.frame.width ?? 0)
    
    public var body: some View {
        GeometryReader {
            let window = $0.size.width
            
            HStack(spacing: 0) {
                EditorView()
                    .frame(width: window * 3 / 4)
                    .environmentObject(contentViewModel)
                
                Divider()
                    .foregroundStyle(Color.secondary)
                    .ignoresSafeArea()
                
                PropertiesView(contentViewModel: contentViewModel)
                    .frame(width: window / 4)
                    .environmentObject(contentViewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .preferredColorScheme(.dark)
    }
}
