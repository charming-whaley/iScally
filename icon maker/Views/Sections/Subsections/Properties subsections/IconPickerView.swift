import SwiftUI

public struct IconPickerView: View {
    @Binding
    var symbol: String
    @Binding
    var symbolColor: Color
    
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
                LazyVGrid(columns: Constants.columns, spacing: 16) {
                    ForEach(Constants.icons, id: \.self) { icon in
                        IconBoxView(iconName: icon)
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
