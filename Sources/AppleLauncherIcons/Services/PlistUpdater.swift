import Foundation

/// Updates Info.plist files with new icon information
struct PlistUpdater {
    
    /// Update Info.plist to reference the app icon set
    static func updateInfoPlist(at path: String, platform: Platform) throws {
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url),
              var plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
            return
        }
        switch platform {
        case .iOS, .tvOS:
            if plist["CFBundleIcons"] == nil {
                plist["CFBundleIcons"] = [String: Any]()
            }
            
            if var bundleIcons = plist["CFBundleIcons"] as? [String: Any] {
                bundleIcons["CFBundlePrimaryIcon"] = [
                    "CFBundleIconFiles": ["AppIcon"],
                    "UIPrerenderedIcon": false
                ]
                plist["CFBundleIcons"] = bundleIcons
            }
            plist["CFBundleIconName"] = "AppIcon"
            
        case .macOS:
            plist["CFBundleIconFile"] = "AppIcon"
            plist["CFBundleIconName"] = "AppIcon"
            
        case .watchOS:
            plist["CFBundleIconName"] = "AppIcon"
            
        case .visionOS:
            plist["CFBundleIconName"] = "AppIcon"
        }
        let updatedData = try PropertyListSerialization.data(
            fromPropertyList: plist,
            format: .xml,
            options: 0
        )
        
        try updatedData.write(to: url)
    }
}