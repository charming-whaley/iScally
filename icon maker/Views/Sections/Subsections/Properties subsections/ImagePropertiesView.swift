import SwiftUI

struct ImagePropertiesView: View {
    var body: some View {
        VStack {
            Text("Additional")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
