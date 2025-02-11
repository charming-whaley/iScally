import SwiftUI

struct PropertiesView: View {
    @State private var activePanel = Panel.backgroundColor
    
    var body: some View {
        VStack(spacing: 15) {
            SegmentedControlView(
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
            
            PanelView()
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func PanelView() -> some View {
        switch activePanel {
        case .backgroundColor:
            BackgroundSelectorView()
        case .icon:
            IconPickerView()
        case .others:
            ImagePropertiesView()
        }
    }
}

#Preview {
    PropertiesView()
    
}
