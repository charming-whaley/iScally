import SwiftUI

struct PropertiesView: View {
    @State
    private var selectedPanel: Panel = .colorSwitcher
    
    var body: some View {
        VStack(spacing: 15) {
            segmentedControlView
            
            SegmentedControlSectionView(selectedPanel)
        }
        .padding(.horizontal)
    }
    
    private var segmentedControlView: some View {
        Picker("", selection: $selectedPanel) {
            ForEach(Panel.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
    }
    
    @ViewBuilder
    private func SegmentedControlSectionView(_ panel: Panel) -> some View {
        switch panel {
        case .colorSwitcher:
            BackgroundSelectorView()
        case .iconSwitcher:
            IconPickerView()
        case .additional:
            ImagePropertiesView()
        }
    }
}

#Preview {
    PropertiesView()
        .frame(width: 300, height: 300)
}
