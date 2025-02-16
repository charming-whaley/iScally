import SwiftUI
 
public struct ImagePropertiesView: View {
    @Binding
    var filename: String
    @Binding
    var hasWatchOSSupport: Bool
    @Binding
    var hasMacOSSupport: Bool
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Preferences")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 14)
            
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    TextField("File name...", text: $filename)
                        .textFieldStyle(.plain)
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(.editorBackground)
                        }
                 
                    Group {
                        CustomToggleView(switcher: $hasMacOSSupport, title: "add macOS sizes")
                        CustomToggleView(switcher: $hasWatchOSSupport, title: "add watchOS sizes")
                    }
                    .padding(.leading, 8)
                }
            } header: {
                Text("File properties")
                    .foregroundStyle(.secondary)
                    .padding(8)
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 19)
    }
}
