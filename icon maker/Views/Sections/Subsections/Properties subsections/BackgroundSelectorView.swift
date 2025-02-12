import SwiftUI

struct BackgroundSelectorView: View {
    private let columns = Array(repeating: GridItem(.fixed(130), spacing: 15), count: 2)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.leading)
            
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(Constants.backgroundColors, id: \.self) { back in
                        BackgroundColorBlockView(back)
                            
                    }
                }
                .padding(.bottom, 15)
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BackgroundSelectorView()
}
