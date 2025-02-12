import SwiftUI

struct BackgroundSelectorView: View {
    private let columns = Array(repeating: GridItem(.fixed(130), spacing: 15), count: 2)
    
    @State private var selectedTab: Color = .red
    @State private var customColor: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.leading)
            
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
                .padding(.horizontal)
                .padding(.bottom, 10)
            
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
    }
}

#Preview {
    BackgroundSelectorView()
}
