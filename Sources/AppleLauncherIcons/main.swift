import ArgumentParser

struct AppleLauncherIcons: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "apple-launcher-icons",
        abstract: "Generate app icons for Apple platforms from a single PNG file",
        discussion: """
        This tool automatically detects Apple platform projects in your directory and generates
        all required app icon sizes from a single source PNG image.

        REQUIREMENTS:
        • Source image must be PNG format
        • Image should be square (same width and height)
        • Minimum size: 512x512 (1024x1024 recommended for best quality)

        HOW IT WORKS:
        1. Detects Xcode projects (.xcodeproj or .xcworkspace) in the current directory
        2. Identifies which Apple platforms are present (iOS, macOS, watchOS, tvOS, visionOS)
        3. Generates all required icon sizes for each platform
        4. Places icons in the appropriate Assets.xcassets/AppIcon locations
        5. Updates Info.plist files to reference the icons

        EXAMPLES:
        Generate icons in current project:
          $ apple-launcher-icons MyIcon.png

        Generate with verbose output:
          $ apple-launcher-icons MyIcon.png --verbose

        Preview without making changes:
          $ apple-launcher-icons MyIcon.png --dry-run

        Force overwrite existing icons:
          $ apple-launcher-icons MyIcon.png --force

        Specify project directory:
          $ apple-launcher-icons MyIcon.png --project-path ~/MyApp

        SUPPORTED PLATFORMS:
        • iOS (iPhone & iPad) - 18 icon sizes
        • macOS - 10 icon sizes
        • watchOS - 15 icon sizes
        • tvOS - 6 icon sizes
        • visionOS - 1 icon size

        For more information, visit: https://github.com/tornikegomareli/apple-launcher-icons
        """,
        version: "0.1.1",
        subcommands: [Generate.self],
        defaultSubcommand: Generate.self
    )
}

AppleLauncherIcons.main()