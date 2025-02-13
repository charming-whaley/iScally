import SwiftUI
 
public struct ImagePropertiesView: View {
    @State private var fileName: String = ""
    @State private var watchOSSupport: Bool = false
    @State private var highQualitySupport: Bool = false
    @State private var archived = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Additional")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 14)
            
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    TextField("File name...", text: $fileName)
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
                        CheckerView(switcher: $highQualitySupport, title: "High quality")
                        CheckerView(switcher: $archived, title: "Create .zip archive")
                        CheckerView(switcher: $watchOSSupport, title: "watchOS Support")
                    }
                    .padding(.leading, 8)
                }
            } header: {
                Text("File properties")
                    .foregroundStyle(.secondary)
                    .padding(8)
            }
            
            Spacer(minLength: 0)
            
            DownloadButtonView {
                
            }
            .padding(.bottom, 19)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 19)
    }
}
