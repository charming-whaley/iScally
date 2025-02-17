import SwiftUI
import Combine

public struct BackgroundPropertiesView: View {
    @Binding
    var currentColor: Color
    @Binding
    var customColor: String
    @Binding
    var hasGradient: Bool
    @State
    private var showErrorAlert = false
    @State
    private var wentToFullScreenMode: Bool = false
    @Binding
    var tintColor: Color
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(String(localized: "properties.background.label"))
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.horizontal, 19)
                .padding(.bottom, 14)
            
            CustomToggleView(
                switcher: $hasGradient,
                title: String(localized: "properties.background.addGradient.label"),
                tintColor: $tintColor
            )
                .padding(.horizontal, 19)
                .padding(.bottom, 15)
             
            CustomColorBlockView()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: wentToFullScreenMode ? Contents.flexibleColumns : Contents.columns, spacing: 16) {
                    ForEach(Contents.backgroundColors) { background in
                        CustomPaletteBoxView(background.customColor)
                            .onTapGesture {
                                withAnimation(.snappy(duration: 0.25, extraBounce: 0)) {
                                    currentColor = background.customColor
                                }
                            }
                            .overlay {
                                if currentColor == background.customColor && customColor.isEmpty {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.clear)
                                        .stroke(.white, lineWidth: 2)
                                        .frame(width: 130, height: 130)
                                        .overlay(alignment: .bottomTrailing) {
                                            Image(systemName: "checkmark.seal.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .padding(10)
                                        }
                                }
                            }
                    }
                }
                .padding([.top, .bottom], 15)
            }
            .ignoresSafeArea()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("Incorrect color format"),
                message: Text("You've entered a wrong color format. Please enter a valid HEX color code"),
                dismissButton: .default(Text("Continue"))
            )
        }
        .onAppear {
            if let window = NSApplication.shared.windows.first {
                wentToFullScreenMode = window.styleMask.contains(.fullScreen)
            }
            
            NotificationCenter.default.addObserver(
                forName: NSWindow.willEnterFullScreenNotification,
                object: nil,
                queue: .main
            ) { _ in
                wentToFullScreenMode = true
            }
            NotificationCenter.default.addObserver(
                forName: NSWindow.willExitFullScreenNotification,
                object: nil,
                queue: .main
            ) { _ in
                wentToFullScreenMode = false
            }
        }
    }
    
    @ViewBuilder
    private func CustomColorBlockView() -> some View {
        GeometryReader {
            let window = $0.size.width
            
            HStack(spacing: 8) {
                TextField(String(localized: "properties.background.field.hint"), text: $customColor)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .frame(width: window * 0.527)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.editorBackground)
                    }
                
                Button {
                    if let customColorHex = Color(hex: customColor) {
                        currentColor = customColorHex
                    } else {
                        showErrorAlert.toggle()
                    }
                    
                    customColor = ""
                } label: {
                    Image(systemName: "paintbrush.pointed.fill")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(tintColor == .yellow ? .black : .white)
                        .padding(.vertical, 10)
                        .frame(width: window * 0.20)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(tintColor)
                        }
                }
                .buttonStyle(.plain)
                
                Button {
                    if let customColorHex = Color(hex: customColor) {
                        Contents.backgroundColors.append(.init(customColor: customColorHex))
                    } else {
                        showErrorAlert.toggle()
                    }
                    
                    customColor = ""
                } label: {
                    Image(systemName: "paintpalette.fill")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundStyle(tintColor == .yellow ? .black : .white)
                        .padding(.vertical, 10)
                        .frame(width: window * 0.20)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(tintColor)
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .frame(height: 57)
        .padding(.horizontal, 19)
    }
}
