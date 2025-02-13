import SwiftUI

public struct EditorView: View {
    @EnvironmentObject
    var contentViewModel: ContentViewModel
    @State
    private var scale: CGFloat = 1.0
    
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
                    imageColor: $contentViewModel.symbolColor
                )
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.2), value: scale)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer(minLength: 0)
            
            HStack {
                ZoomInOutView(scale: $scale)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("EditorBackgroundColor"))
    }
}
