import SwiftUI

public struct RootView: View {
    @StateObject
    var contentViewModel = ContentViewModel()
    
    public var body: some View {
        HStack(spacing: 0) {
            EditorView()
                .frame(width: 1280 * 3 / 4)
                .environmentObject(contentViewModel)
            
            Divider()
                .foregroundStyle(Color.secondary)
                .ignoresSafeArea()
            
            PropertiesView(contentViewModel: contentViewModel)
                .frame(width: 1280 / 4)
                .environmentObject(contentViewModel)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}
