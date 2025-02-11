import SwiftUI

@main
struct icon_makerApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .onAppear {
                    DispatchQueue.main.async {
                        NSApplication.shared.windows.forEach { window in
                            window.standardWindowButton(.zoomButton)?.isEnabled = false
                        }
                    }
                }
                .background(Color.black)
        }
        .defaultSize(width: 1280, height: 720)
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
    }
}
