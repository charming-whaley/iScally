import SwiftUI

struct BackgroundSelectorView: View {
    var body: some View {
        VStack {
            Text("Background")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
