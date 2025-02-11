import SwiftUI

struct IconPickerView: View {
    var body: some View {
        VStack {
            Text("Icons")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
