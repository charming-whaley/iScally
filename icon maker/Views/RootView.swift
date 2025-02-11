import SwiftUI

struct RootView: View {
    var body: some View {
        HStack(spacing: 0) {
            EditorView()
                .frame(width: 1280 * 3 / 4)
            
            Divider()
                .foregroundStyle(Color.secondary)
                .ignoresSafeArea()
            
            PropertiesView()
                .frame(width: 1280 / 4)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}
