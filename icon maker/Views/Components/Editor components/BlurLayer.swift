import SwiftUI

public struct BlurLayer: NSViewRepresentable {
    public func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        return view
    }
    
    public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {  }
}
