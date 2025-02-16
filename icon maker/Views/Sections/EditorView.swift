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
    @State
    private var hasZoomAppeared: Bool = false
    @State
    private var hasErrorRenderingImageThrown: Bool = false
    @State
    private var hasErrorCreatingDirectoryThrown: Bool = false
    @State
    private var keyDownMonitor: Any?
    
    public var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            HStack {
                FieldView(
                    backgroundColor: $contentViewModel.originalColor,
                    hasGradient: $contentViewModel.hasGradient,
                    imageName: $contentViewModel.currentSymbol,
                    imageColor: $contentViewModel.symbolColor,
                    hasShadow: $hasShadow
                )
                .scaleEffect(scale)
                .animation(.easeInOut(duration: 0.2), value: scale)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay(alignment: .topTrailing) {
                if hasZoomAppeared {
                    Text("\(String(format: "%.1f", scale))x")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.white)
                        .padding(.bottom, -500)
                }
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 10) {
                ZoomView(scale: $scale)
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
        .background(BlurLayer())
        .ignoresSafeArea()
        .onChange(of: scale) { oldValue, newValue in
            if newValue < 1.0 || newValue > 1.0 || oldValue < 1.0 || oldValue > 1.0 {
                withAnimation(.easeIn) {
                    hasZoomAppeared.toggle()
                }
                
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(0.9))
                    withAnimation(.easeOut) {
                        hasZoomAppeared.toggle()
                    }
                }
            }
        }
        .alert(isPresented: $hasErrorRenderingImageThrown) {
            Alert(
                title: Text("Image rendering error"),
                message: Text("There was an error rendering image pack. Please try again or relaunch the app."),
                dismissButton: .default(Text("Continue"))
            )
        }
        .alert(isPresented: $hasErrorCreatingDirectoryThrown) {
            Alert(
                title: Text("Saving images error"),
                message: Text("There was an error saving images on your Mac. Please try again or relaunch the app."),
                dismissButton: .default(Text("Continue"))
            )
        }
        .onAppear {
            keyDownMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown, handler: { event in
                if event.modifierFlags.contains(.command), event.charactersIgnoringModifiers?.lowercased() == "s" {
                    performDownloadAction()
                    return nil
                }
                return event
            })
        }
        .onDisappear {
            if let monitor = keyDownMonitor {
                NSEvent.removeMonitor(monitor)
                keyDownMonitor = nil
            }
        }
    }
}

extension EditorView {
    @ViewBuilder
    private func DownloadButtonView() -> some View {
        Button {
            performDownloadAction()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "arrow.down.circle.fill")
                Text("Download")
            }
            .font(.title2)
            .foregroundStyle(.black)
            .fontWeight(.heavy)
            .frame(width: 160, height: 55)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.yellow)
            }
        }
        .buttonStyle(.plain)
    }
    
    private func performDownloadAction() {
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
                    hasErrorCreatingDirectoryThrown.toggle()
                    return
                }
            }
        }
    }
    
    private func renderIconFieldViewAsNSImage(withWidth width: CGFloat, AndHeight height: CGFloat) -> NSImage {
        let hostingViewController = NSHostingView(rootView: FieldView(
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
        guard let bitmapRep = hostingViewController.bitmapImageRepForCachingDisplay(in: hostingViewController.bounds) else {
            hasErrorRenderingImageThrown.toggle()
            return NSImage()
        }
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
