import SwiftUI
import AppKit

public struct TopLayerPickerView: View {
    @Binding
    var symbol: String
    @Binding
    var symbolColor: Color
    @State
    private var wentToFullScreenMode: Bool = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Top Layer")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.horizontal, 19)
                .padding(.bottom, 14)
            
            IconBackgroundSelector()
                .padding(.bottom, 16)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: wentToFullScreenMode ? Contents.flexibleColumns : Contents.columns, spacing: 16) {
                    ForEach(Contents.icons, id: \.self) { icon in
                        IconView(iconName: icon)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    symbol = icon
                                }
                            }
                            .overlay {
                                if symbol == icon {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 3)
                                        .frame(width: 130, height: 130)
                                        .overlay(alignment: .bottomTrailing) {
                                            Image(systemName: "checkmark.seal.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .padding(10)
                                        }
                                }
                            }
                    }
                }
                .padding([.top, .bottom], 15)
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
            if let window = NSApplication.shared.windows.first {
                wentToFullScreenMode = window.styleMask.contains(.fullScreen)
            }
            
            NotificationCenter.default.addObserver(
                forName: NSWindow.willEnterFullScreenNotification,
                object: nil,
                queue: .main
            ) { _ in
                wentToFullScreenMode = true
            }
            NotificationCenter.default.addObserver(
                forName: NSWindow.willExitFullScreenNotification,
                object: nil,
                queue: .main
            ) { _ in
                wentToFullScreenMode = false
            }
        }
    }
    
    @ViewBuilder
    private func IconBackgroundSelector() -> some View {
        HStack(spacing: 0) {
            Text("Tint color: ")
                .font(.system(size: 14))
            
            Spacer(minLength: 0)
            
            CustomColorPicker(color: $symbolColor)
                .frame(width: 40, height: 16)
        }
        .padding(.horizontal, 19)
    }
}
