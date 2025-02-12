import SwiftUI

public struct BackgroundSelectorView: View {
    private let columns = Array(repeating: GridItem(.fixed(130), spacing: 15), count: 2)
    
    @State private var selectedTab: Color = .red
    @State private var customColor = ""
    @State private var showErrorAlert = false
    @State private var switcher = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.leading)
                .padding(.bottom, 14)
            
            CheckerView(switcher: $switcher, title: "Add gradient")
                .padding(.horizontal)
                .padding(.bottom, 15)
            
            CustomColorBlockView()
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(Constants.backgroundColors, id: \.self) { back in
                        BackgroundColorBlockView(back)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    selectedTab = back
                                }
                            }
                            .overlay {
                                if selectedTab == back && customColor.isEmpty {
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
                    selectedTab = customColorHex
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
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

#Preview {
    BackgroundSelectorView()
}
