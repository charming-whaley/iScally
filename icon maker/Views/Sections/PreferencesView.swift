import SwiftUI
 
public struct PreferencesView: View {
    @Binding
    var filename: String
    @Binding
    var hasWatchOSSupport: Bool
    @Binding
    var hasMacOSSupport: Bool
    @Binding
    var colorScheme: Color
    @State
    private var selectedLanguage: String = Locale.current.identifier
    @State
    private var translated: Bool = false
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(String(localized: "properties.preferences.label"))
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding(.bottom, 14)
            
            Section {
                CustomColorSchemeView(colorScheme: $colorScheme)
                    .padding(.horizontal, 2)
                    .padding(.bottom, 8)
            } header: {
                Text(String(localized: "properties.firstSection.label"))
                    .foregroundStyle(.secondary)
                    .padding(8)
            }
            
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    TextField(String(localized: "properties.thirdSection.field.hint"), text: $filename)
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
                        CustomToggleView(
                            switcher: $hasMacOSSupport,
                            title: String(localized: "properties.thirdSection.firstCheckBox.label"),
                            tintColor: $colorScheme
                        )
                        CustomToggleView(
                            switcher: $hasWatchOSSupport,
                            title: String(localized: "properties.thirdSection.secondCheckBox.label"),
                            tintColor: $colorScheme
                        )
                    }
                    .padding(.leading, 8)
                }
            } header: {
                Text(String(localized: "properties.thirdSection.label"))
                    .foregroundStyle(.secondary)
                    .padding(8)
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 19)
        .onChange(of: translated) { _, newValue in
            if translated {
                selectedLanguage = "ru"
            } else {
                selectedLanguage = "en"
            }
        }
        .environment(\.locale, Locale(identifier: selectedLanguage))
    }
}
