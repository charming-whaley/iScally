import SwiftUI
import Combine

public struct CustomColorPicker: NSViewRepresentable {
    @Binding
    var color: Color
    
    public func makeNSView(context: Context) -> NSColorWell {
        let colorWell = NSColorWell(style: .minimal)
        colorWell.color = NSColor(color)
        
        context.coordinator.startObservingColorChange(of: colorWell)
        return colorWell
    }
    
    public func updateNSView(_ nsView: NSColorWell, context: Context) {
        nsView.color = NSColor(color)
        context.coordinator.colorDidChange = {
            color = Color(nsColor: $0)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    @MainActor
    final public class Coordinator: NSObject {
        var colorDidChange: ((NSColor) -> Void)?
        
        private var cancellable: AnyCancellable?
        
        func startObservingColorChange(of colorWell: NSColorWell) {
            cancellable = colorWell.publisher(for: \.color).sink { [weak self] in
                self?.colorDidChange?($0)
            }
        }
    }
}
