import SwiftUI
import Foundation
import AppKit

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
        .background {
            Image("grid")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.3)
        }
        .background(Color("EditorBackgroundColor"))
        .ignoresSafeArea()
    }
}

extension EditorView {
    @ViewBuilder
    private func DownloadButtonView() -> some View {
        Button {
            var images = [NSImage]()
            if contentViewModel.hasWatchOSSupport && !contentViewModel.hasMacOSSupport {
                images = (Contents.extendedImageSizesWatchOS).map { size in
                    renderIconFieldViewAsNSImage(
                        withWidth: size.width,
                        AndHeight: size.height
                    )
                }
            } else if !contentViewModel.hasWatchOSSupport && contentViewModel.hasMacOSSupport {
                images = (Contents.extendedImageSizesMacOS).map { size in
                    renderIconFieldViewAsNSImage(
                        withWidth: size.width,
                        AndHeight: size.height
                    )
                }
            } else if contentViewModel.hasWatchOSSupport && contentViewModel.hasMacOSSupport {
                images = (Contents.extendedImageSizes).map { size in
                    renderIconFieldViewAsNSImage(
                        withWidth: size.width,
                        AndHeight: size.height
                    )
                }
            } else {
                images = (Contents.standardImageSizes).map { size in
                    renderIconFieldViewAsNSImage(
                        withWidth: size.width,
                        AndHeight: size.height
                    )
                }
            }
            downloadImagesOnComputer(images)
        } label: {
            Image(systemName: "arrow.down.circle.fill")
                .font(.title2)
                .foregroundStyle(.black)
                .fontWeight(.heavy)
                .frame(width: 60, height: 60)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.yellow)
                }
        }
        .buttonStyle(.plain)
    }
    
    private func downloadImagesOnComputer(_ images: [NSImage]) {
        let panel = NSSavePanel()
        panel.title = "Save on your Mac computer"
        panel.nameFieldStringValue = "\($contentViewModel.filename.wrappedValue).zip"
        panel.allowedFileTypes = ["zip"]
        
        panel.begin { response in
            if response == .OK, let url = panel.url {
                let fileManager = FileManager.default
                let tempDirectory = fileManager.temporaryDirectory.appendingPathComponent("\($contentViewModel.filename.wrappedValue)")
                
                do {
                    try fileManager.createDirectory(at: tempDirectory, withIntermediateDirectories: true)
                    
                    for (_, image) in images.enumerated() {
                        let imageURL = tempDirectory.appendingPathComponent("\(Int(image.size.width))x\(Int(image.size.height)).png")
                        if let pngData = image.pngData {
                            try pngData.write(to: imageURL)
                        }
                    }
                    
                    let process = Process()
                    process.executableURL = URL(fileURLWithPath: "/usr/bin/ditto")
                    process.arguments = ["-c", "-k", "--sequesterRsrc", "--keepParent", tempDirectory.path, url.path]
                    try process.run()
                    process.waitUntilExit()
                    try fileManager.removeItem(at: tempDirectory)
                } catch {
                    return
                }
            }
        }
    }
    
    private func renderIconFieldViewAsNSImage(withWidth width: CGFloat, AndHeight height: CGFloat) -> NSImage {
        let hostingViewController = NSHostingView(rootView: IconFieldView(
            backgroundColor: $contentViewModel.originalColor,
            hasGradient: $contentViewModel.hasGradient,
            imageName: $contentViewModel.currentSymbol,
            imageColor: $contentViewModel.symbolColor,
            hasShadow: $hasShadow,
            width: width,
            height: height,
            radius: 0
        ))
        let size = CGSize(
            width: width,
            height: height
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
