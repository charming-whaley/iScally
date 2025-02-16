import SwiftUI
import Combine

public struct PropertiesView: View {
    @ObservedObject
    var contentViewModel: ContentViewModel
    @State
    private var activePanel: Panel = .backgroundColor
    @State
    private var wentToFullScreenMode: Bool = false
    
    public var body: some View {
        VStack(spacing: 30) {
            CustomSegmentedControlView(
                panels: Panel.allCases,
                activePanel: $activePanel,
                activeTint: .black,
                inActiveTint: Color.secondary.opacity(0.7)
            ) { size in
                Capsule()
                    .fill(Color.yellow)
                    .frame(height: size.height)
                    .padding(.horizontal, 0)
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
            .padding(.top, wentToFullScreenMode ? 40 : 0)
            .padding(.horizontal)
            .onAppear {
                checkFullscreenModeStatus()
                
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
            
            PanelView()
        }
        .background(Color.black)
    }
    
    private func checkFullscreenModeStatus() {
        if let window = NSApplication.shared.windows.first {
            wentToFullScreenMode = window.styleMask.contains(.fullScreen)
        }
    }
    
    @ViewBuilder
    private func PanelView() -> some View {
        switch activePanel {
        case .backgroundColor:
            BackgroundPropertiesView(
                currentColor: $contentViewModel.originalColor,
                customColor: $contentViewModel.customColor,
                hasGradient: $contentViewModel.hasGradient
            )
        case .icon:
            TopLayerPickerView(
                symbol: $contentViewModel.currentSymbol,
                symbolColor: $contentViewModel.symbolColor
            )
        case .others:
            PreferencesView(
                filename: $contentViewModel.filename,
                hasWatchOSSupport: $contentViewModel.hasWatchOSSupport,
                hasMacOSSupport: $contentViewModel.hasMacOSSupport
            )
        }
    }
}
