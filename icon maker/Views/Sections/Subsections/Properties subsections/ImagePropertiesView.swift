import SwiftUI

struct ImagePropertiesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Additional")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
            
            VStack(alignment: .leading) {
                Text("File properties")
                    .font(.caption)
                    .foregroundStyle(Color.secondary.opacity(0.6))
            }
            
            VStack(alignment: .leading) {
                Text("Download")
                    .font(.caption)
                    .foregroundStyle(Color.secondary.opacity(0.6))
                
                DownloadButtonView {
                    
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
