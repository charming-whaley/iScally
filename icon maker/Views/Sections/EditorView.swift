import SwiftUI
import AppKit
import Cocoa

public struct EditorView: View {
    @EnvironmentObject
    var contentViewModel: ContentViewModel
    @State
    private var scale: CGFloat = 1.0
    @State
    private var hasShadow: Bool = false
    
    public var body: some View {
        VStack {
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
            downloadImageOnComputer(renderIconFieldViewAsNSImage())
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
    
    private func renderIconFieldViewAsNSImage() -> NSImage {
        let hostingViewController = NSHostingView(rootView: IconFieldView(
            backgroundColor: $contentViewModel.originalColor,
            hasGradient: $contentViewModel.hasGradient,
            imageName: $contentViewModel.currentSymbol,
            imageColor: $contentViewModel.symbolColor,
            hasShadow: $hasShadow
        ))
        let size = CGSize(
            width: 800,
            height: 800
        )
        hostingViewController.frame = CGRect(
            origin: .zero,
            size: size
        )
        guard let bitmapRep = hostingViewController.bitmapImageRepForCachingDisplay(in: hostingViewController.bounds) else { return NSImage() }
        hostingViewController.cacheDisplay(in: hostingViewController.bounds, to: bitmapRep)
        
        let image = NSImage(size: size)
        image.addRepresentation(bitmapRep)
        return image
    }
    
    private func downloadImageOnComputer(_ image: NSImage) {
        let panel = NSSavePanel()
        panel.allowedFileTypes = ["png"]
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                guard let pngData = image.pngData else { return }
                try? pngData.write(to: url)
            }
        }
    }
}

extension NSImage {
    var pngData: Data? {
        guard
            let tiffRepresentation = tiffRepresentation,
            let bitmapImageRep = NSBitmapImageRep(data: tiffRepresentation)
        else {
            return nil
        }
        return bitmapImageRep.representation(using: .png, properties: [:])
    }
}
