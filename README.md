# Apple Launcher Icons

⚠️ **Note**: This tool has been thoroughly tested with iOS projects. Support for macOS, watchOS, tvOS, and visionOS is implemented but not yet fully tested. If you encounter any issues with these platforms, please open an issue. I'll be testing each platform step by step and providing patches as needed.

## What is this?

Apple Launcher Icons is a command-line tool that generates all the different sizes of app icons you need for Apple platforms from a single PNG image. If you've ever had to manually resize your app icon to 20+ different sizes for an iOS app, you know how tedious this can be. This tool automates that entire process.

## How it works

When you run this tool in your Xcode project directory with a PNG image, it:

1. Scans your directory for Xcode project files (.xcodeproj or .xcworkspace)
2. Looks inside your project structure to find which Apple platforms you're targeting (iOS, macOS, etc.)
3. Generates all required icon sizes for each platform it finds
4. Places them in the correct Assets.xcassets/AppIcon.appiconset location
5. Creates or updates the Contents.json file that tells Xcode about all the icons
6. Optionally updates your Info.plist to ensure the icons are properly referenced

The tool is smart enough to detect empty icon sets (common in new Xcode projects) and will overwrite them automatically. If you already have icons, it will warn you and require the --force flag to overwrite them.

## Installation

### Using Homebrew (Recommended)

The easiest way to install is via Homebrew:

```bash
brew tap tornikegomareli/tap
brew install apple-launcher-icons
```

Or install directly without adding the tap:

```bash
brew install tornikegomareli/tap/apple-launcher-icons
```

### Quick Install from Source

If you prefer to build from source:

```bash
git clone https://github.com/tornikegomareli/apple-launcher-icons.git
cd apple-launcher-icons
./install.sh
```

This will build the tool and install it to /usr/local/bin so you can use it from anywhere.

### Manual Build

For manual building:

```bash
git clone https://github.com/tornikegomareli/apple-launcher-icons.git
cd apple-launcher-icons
swift build -c release
```

The built executable will be at `.build/release/apple-launcher-icons`

## Requirements

Before using this tool, make sure you have:

- macOS 13.0 or later
- Swift 5.9 or later (comes with Xcode)
- A PNG image that is:
  - Square (same width and height)
  - At least 512x512 pixels (though 1024x1024 or larger is recommended for best quality)

## Usage

### Basic Usage

The simplest way to use the tool is to navigate to your Xcode project directory and run:

```bash
apple-launcher-icons YourIcon.png
```

This will:
- Look for Xcode projects in the current directory
- Detect which platforms you're building for
- Generate all required icon sizes
- Place them in the appropriate locations

### Command Options

#### Specifying a Different Project Directory

If you're not in your project directory, you can specify where your project is:

```bash
apple-launcher-icons YourIcon.png --project-path ~/Projects/MyApp
```

or the short version:

```bash
apple-launcher-icons YourIcon.png -p ~/Projects/MyApp
```

#### Verbose Output

To see exactly what the tool is doing, use verbose mode:

```bash
apple-launcher-icons YourIcon.png --verbose
```

or:

```bash
apple-launcher-icons YourIcon.png -v
```

This will show you:
- The exact path where icons are being generated
- Each icon size being created
- Where the Contents.json is being written
- Whether Info.plist is being updated

#### Dry Run Mode

Want to see what would happen without actually creating any files? Use dry-run:

```bash
apple-launcher-icons YourIcon.png --dry-run
```

This is perfect for testing or verifying what the tool will do before committing to changes.

#### Force Overwrite

If you already have icons in your project and want to replace them:

```bash
apple-launcher-icons YourIcon.png --force
```

or:

```bash
apple-launcher-icons YourIcon.png -f
```

Note: You don't need --force for empty icon sets (like in new projects). The tool is smart enough to detect these and overwrite them automatically.

### Real-World Examples

#### Typical iOS App Workflow

1. Create a new iOS app in Xcode
2. Design your app icon (1024x1024 PNG recommended)
3. In Terminal, navigate to your project:
   ```bash
   cd ~/Projects/MyAwesomeApp
   ```
4. Run the tool:
   ```bash
   apple-launcher-icons AppIcon.png
   ```
5. Check Xcode - your app icon should now be set with all sizes filled in!

#### Multi-Platform Project

If you have a project that targets both iOS and macOS:

```bash
apple-launcher-icons Icon.png --verbose
```

The tool will detect both platforms and generate:
- 18 different sizes for iOS
- 10 different sizes for macOS

#### Previewing Changes

Before making changes to an existing project:

```bash
apple-launcher-icons NewIcon.png --dry-run --verbose
```

This shows you exactly what would be generated without touching any files.

## Platform Support

Currently, the tool can generate icons for:

- **iOS** (iPhone & iPad): Generates 18 different icon sizes from 20x20 up to 1024x1024
- **macOS**: Generates 10 different icon sizes from 16x16 up to 1024x1024
- **watchOS**: Generates 15 different icon sizes for Apple Watch
- **tvOS**: Generates 6 different icon sizes for Apple TV
- **visionOS**: Generates icons for Apple Vision Pro

## Understanding the Output

When you run the tool, you'll see output like this:

```
🎨 Apple Launcher Icons Generator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Detected platforms:
   • iOS at ./MyApp

🚀 Generating iOS icons...
   ✓ Generated 18 icons

✨ Successfully generated all icons!
```

If you use verbose mode, you'll see much more detail:

```
📸 Loading image from: AppIcon.png
🔍 Detecting Apple platforms in: .
📁 Icon set path: ./MyApp/Assets.xcassets/AppIcon.appiconset
   • Generating Icon-20x20@2x.png (40x40)
   • Generating Icon-20x20@3x.png (60x60)
   ... (and so on for each size)
   • Generating Contents.json
   • Updating Info.plist
```

## Troubleshooting

### "No Xcode project found"

Make sure you're in a directory that contains a .xcodeproj or .xcworkspace file. The tool needs to find an Xcode project to know where to place the icons.

### "Image must be square"

Your source image needs to have the same width and height. If your designer gave you a 1024x768 image, you'll need to crop or adjust it to be square first.

### "Image must be at least 512x512 pixels"

While the tool accepts images as small as 512x512, using a 1024x1024 or larger image will give you better quality icons, especially for retina displays.

### Icons not showing up in Xcode

After running the tool:
1. Go to Xcode
2. Clean build folder (Shift+Cmd+K)
3. Build again

Sometimes Xcode needs a refresh to pick up the new icons.

## How Icon Generation Works

The tool uses Core Graphics (Apple's graphics framework) to resize your image. It employs high-quality interpolation to ensure your icons look crisp at all sizes. The specific algorithm adjusts based on whether it's scaling up or down to maintain the best possible quality.

For the technically curious:
- Scaling down: Uses average interpolation for smooth results
- Scaling up: Uses linear interpolation (though you should avoid this by using a large source image)

## Contributing

Found a bug? Have an idea for improvement? Feel free to:

1. Open an issue describing what you found
2. Fork the repository
3. Make your changes
4. Submit a pull request

I'm particularly interested in feedback about the platforms beyond iOS, as these need more real-world testing.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Created by Tornike Gomareli. If this tool saved you time, feel free to let me know!