import SwiftUI

struct DownloadButtonView: View {
    let action: () async -> Void
    
    init(_ action: @escaping () async -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button {
            Task { @MainActor in
                await action()
            }
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "arrow.down.circle.fill")
                Text("Download")
            }
            .foregroundStyle(.black)
            .font(.title2)
            .fontWeight(.heavy)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.yellow)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DownloadButtonView {
        
    }
}
