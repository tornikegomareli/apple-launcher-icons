import Foundation

enum Platform: String, CaseIterable {
    case iOS = "iOS"
    case macOS = "macOS"
    case watchOS = "watchOS"
    case tvOS = "tvOS"
    case visionOS = "visionOS"
    
    var assetCatalogName: String {
        switch self {
        case .iOS, .watchOS:
            return "AppIcon.appiconset"
        case .macOS:
            return "AppIcon.appiconset"
        case .tvOS:
            return "App Icon & Top Shelf Image.brandassets/App Icon.imagestack"
        case .visionOS:
            return "AppIcon.solidimagestack"
        }
    }
    
    var iconTemplates: [IconTemplate] {
        switch self {
        case .iOS:
            return IconTemplate.iOSTemplates
        case .macOS:
            return IconTemplate.macOSTemplates
        case .watchOS:
            return IconTemplate.watchOSTemplates
        case .tvOS:
            return IconTemplate.tvOSTemplates
        case .visionOS:
            return IconTemplate.visionOSTemplates
        }
    }
}

struct IconTemplate {
    let size: Double
    let scale: Double
    let idiom: String
    let platform: String?
    
    var pixelSize: Int {
        Int(size * scale)
    }
    
    var filename: String {
        if size == 83.5 {
            return "Icon-83.5x83.5@\(Int(scale))x.png"
        }
        if scale == 1 {
            return "Icon-\(Int(size))x\(Int(size)).png"
        } else {
            return "Icon-\(Int(size))x\(Int(size))@\(Int(scale))x.png"
        }
    }
    static let iOSTemplates: [IconTemplate] = [
        IconTemplate(size: 20, scale: 2, idiom: "iphone", platform: nil),
        IconTemplate(size: 20, scale: 3, idiom: "iphone", platform: nil),
        IconTemplate(size: 29, scale: 2, idiom: "iphone", platform: nil),
        IconTemplate(size: 29, scale: 3, idiom: "iphone", platform: nil),
        IconTemplate(size: 40, scale: 2, idiom: "iphone", platform: nil),
        IconTemplate(size: 40, scale: 3, idiom: "iphone", platform: nil),
        IconTemplate(size: 60, scale: 2, idiom: "iphone", platform: nil),
        IconTemplate(size: 60, scale: 3, idiom: "iphone", platform: nil),
        IconTemplate(size: 20, scale: 1, idiom: "ipad", platform: nil),
        IconTemplate(size: 20, scale: 2, idiom: "ipad", platform: nil),
        IconTemplate(size: 29, scale: 1, idiom: "ipad", platform: nil),
        IconTemplate(size: 29, scale: 2, idiom: "ipad", platform: nil),
        IconTemplate(size: 40, scale: 1, idiom: "ipad", platform: nil),
        IconTemplate(size: 40, scale: 2, idiom: "ipad", platform: nil),
        IconTemplate(size: 76, scale: 1, idiom: "ipad", platform: nil),
        IconTemplate(size: 76, scale: 2, idiom: "ipad", platform: nil),
        IconTemplate(size: 83.5, scale: 2, idiom: "ipad", platform: nil),
        IconTemplate(size: 1024, scale: 1, idiom: "ios-marketing", platform: nil)
    ]
    static let macOSTemplates: [IconTemplate] = [
        IconTemplate(size: 16, scale: 1, idiom: "mac", platform: nil),
        IconTemplate(size: 16, scale: 2, idiom: "mac", platform: nil),
        IconTemplate(size: 32, scale: 1, idiom: "mac", platform: nil),
        IconTemplate(size: 32, scale: 2, idiom: "mac", platform: nil),
        IconTemplate(size: 128, scale: 1, idiom: "mac", platform: nil),
        IconTemplate(size: 128, scale: 2, idiom: "mac", platform: nil),
        IconTemplate(size: 256, scale: 1, idiom: "mac", platform: nil),
        IconTemplate(size: 256, scale: 2, idiom: "mac", platform: nil),
        IconTemplate(size: 512, scale: 1, idiom: "mac", platform: nil),
        IconTemplate(size: 512, scale: 2, idiom: "mac", platform: nil)
    ]
    static let watchOSTemplates: [IconTemplate] = [
        IconTemplate(size: 24, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 27.5, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 29, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 29, scale: 3, idiom: "watch", platform: nil),
        IconTemplate(size: 33, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 40, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 44, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 46, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 50, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 51, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 54, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 86, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 98, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 108, scale: 2, idiom: "watch", platform: nil),
        IconTemplate(size: 1024, scale: 1, idiom: "watch-marketing", platform: nil)
    ]
    static let tvOSTemplates: [IconTemplate] = [
        IconTemplate(size: 400, scale: 1, idiom: "tv", platform: nil),
        IconTemplate(size: 400, scale: 2, idiom: "tv", platform: nil),
        IconTemplate(size: 1280, scale: 1, idiom: "tv", platform: nil),
        IconTemplate(size: 1280, scale: 2, idiom: "tv", platform: nil),
        IconTemplate(size: 2320, scale: 1, idiom: "tv-marketing", platform: nil),
        IconTemplate(size: 3840, scale: 1, idiom: "tv-marketing", platform: nil)
    ]
    static let visionOSTemplates: [IconTemplate] = [
        IconTemplate(size: 1024, scale: 1, idiom: "vision", platform: nil)
    ]
}