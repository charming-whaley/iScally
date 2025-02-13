import SwiftUI

public struct PropertiesView: View {
    @ObservedObject
    var contentViewModel: ContentViewModel
    @State
    private var activePanel: Panel = .backgroundColor
    
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
            .padding(.horizontal)
            
            PanelView()
        }
        .background(Color.black)
    }
    
    @ViewBuilder
    private func PanelView() -> some View {
        switch activePanel {
        case .backgroundColor:
            BackgroundSelectorView(
                currentColor: $contentViewModel.originalColor,
                customColor: $contentViewModel.customColor,
                hasGradient: $contentViewModel.hasGradient
            )
        case .icon:
            IconPickerView(
                symbol: $contentViewModel.currentSymbol,
                symbolColor: $contentViewModel.symbolColor
            )
        case .others:
            ImagePropertiesView(
                filename: $contentViewModel.filename,
                hasWatchOSSupport: $contentViewModel.hasWatchOSSupport,
                hasHighQualitySupport: $contentViewModel.hasHigherQuality,
                archived: $contentViewModel.archiveImages
            )
        }
    }
}
