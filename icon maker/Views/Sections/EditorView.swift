import SwiftUI

public struct EditorView: View {
    @EnvironmentObject
    var contentViewModel: ContentViewModel
    @State
    private var scale: CGFloat = 1.0
    @State
    private var hasShadow: Bool = false
    
    public var body: some View {
        VStack {
            HStack {
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer(minLength: 0)
            
            HStack {
                IconFieldView(
                    backgroundColor: $contentViewModel.originalColor,
                    hasGradient: $contentViewModel.hasGradient,
                    imageName: $contentViewModel.currentSymbol,
                    imageColor: $contentViewModel.symbolColor,
                    hasShadow: $hasShadow
                )
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.2), value: scale)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer(minLength: 0)
            
            HStack {
                ZoomInOutView(scale: $scale)
                Spacer(minLength: 0)
                DownloadButtonView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("EditorBackgroundColor"))
    }
}

extension EditorView {
    @ViewBuilder
    private func DownloadButtonView() -> some View {
        Button {
            
        } label: {
            Image(systemName: "arrow.down.circle.fill")
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.heavy)
                .frame(width: 60, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                }
        }
        .buttonStyle(.plain)
    }
}
