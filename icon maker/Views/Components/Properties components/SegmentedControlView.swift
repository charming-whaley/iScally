import SwiftUI

public struct SegmentedControlView<Indicator>: View where Indicator: View {
    var panels: [Panel]
    @Binding
    var activePanel: Panel
    var height: CGFloat = 35
    
    var font: Font = .body
    var activeTint: Color
    var inActiveTint: Color
    
    @ViewBuilder
    var indicatorView: (CGSize) -> Indicator
    
    @State
    private var excessed: CGFloat = .zero
    @State
    private var minX: CGFloat = .zero
    
    public var body: some View {
        GeometryReader {
            let size = $0.size
            let containerWidth = size.width / CGFloat(panels.count)
            
            HStack(spacing: 0) {
                ForEach(panels, id: \.rawValue) { panel in
                    Image(systemName: panel.rawValue)
                        .font(font)
                        .foregroundStyle(activePanel == panel ? activeTint : inActiveTint)
                        .animation(.snappy, value: activePanel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(.rect)
                        .onTapGesture {
                            if let index = panels.firstIndex(of: panel), let activeIndex = panels.firstIndex(of: activePanel) {
                                activePanel = panel
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0), completionCriteria: .logicallyComplete) {
                                    excessed = containerWidth * CGFloat(index - activeIndex)
                                } completion: {
                                    minX = containerWidth * CGFloat(index)
                                    excessed = .zero
                                }
                            }
                        }
                        .background(alignment: .leading) {
                            if panels.first == panel {
                                GeometryReader {
                                    let size = $0.size
                                    
                                    indicatorView(size)
                                        .frame(
                                            width: size.width + (excessed < 0 ? -excessed : excessed),
                                            height: size.height
                                        )
                                        .frame(
                                            width: size.width,
                                            alignment: excessed < 0 ? .trailing : .leading
                                        )
                                        .offset(x: minX)
                                }
                            }
                        }
                }
            }
            .preference(key: SizeKey.self, value: size)
            .onPreferenceChange(SizeKey.self) { size in
                if let index = panels.firstIndex(of: activePanel) {
                    minX = containerWidth * CGFloat(index)
                    excessed = .zero
                }
            }
        }
        .frame(height: height)
    }
}

struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
