import SwiftUI

struct ShadowSwitcherButtonView: View {
    @Binding
    var hasShadow: Bool
    
    var body: some View {
        Button {
            withAnimation(.snappy(duration: 0.2, extraBounce: 0)) {
                hasShadow.toggle()
            }
        } label: {
            Image(systemName: "moonphase.waxing.crescent")
                .font(.title2)
                .foregroundStyle(hasShadow ? .black : .white)
                .fontWeight(.heavy)
                .frame(width: 60, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(hasShadow ? .yellow : .black)
                }
        }
        .buttonStyle(.plain)
    }
}
