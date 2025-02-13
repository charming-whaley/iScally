import SwiftUI

public struct BackgroundSelectorView: View {
    @Binding
    var currentColor: Color
    @Binding
    var customColor: String
    @Binding
    var hasGradient: Bool
    @State
    private var showErrorAlert = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.horizontal, 19)
                .padding(.bottom, 14)
            
            CheckerView(switcher: $hasGradient, title: "Add gradient")
                .padding(.horizontal, 19)
                .padding(.bottom, 15)
             
            CustomColorBlockView()
                .padding(.bottom, 8)
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Constants.columns, spacing: 16) {
                    ForEach(Constants.backgroundColors, id: \.self) { background in
                        BackgroundColorBlockView(background)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    currentColor = background
                                }
                            }
                            .overlay {
                                if currentColor == background && customColor.isEmpty {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 2)
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
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Incorrect color format"),
                message: Text("You've entered a wrong color format. Please enter a valid HEX color code"),
                dismissButton: .default(Text("Continue"))
            )
        }
    }
    
    @ViewBuilder
    private func CustomColorBlockView() -> some View {
        HStack(spacing: 8) {
            TextField("Your hex color...", text: $customColor)
                .textFieldStyle(.plain)
                .padding(.horizontal)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.editorBackground)
                }
            
            Button {
                if let customColorHex = Color(hex: customColor) {
                    currentColor = customColorHex
                } else {
                    showErrorAlert.toggle()
                }
            } label: {
                Image(systemName: "paintbrush.pointed.fill")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundStyle(.black)
                    .padding(.vertical, 10)
                    .frame(width: 60)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.yellow)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 19)
        .padding(.bottom, 8)
    }
}
