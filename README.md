# Apple Launcher Icons

A Swift command-line tool that automatically generates app icons for all Apple platforms from a single PNG file. It detects your project type and places icons in the correct locations while updating Info.plist files.

## Features

- 🎯 **Automatic Platform Detection**: Detects iOS, macOS, watchOS, tvOS, and visionOS projects
- 📁 **Smart Icon Placement**: Places icons in the correct Asset Catalog locations
- 📝 **Info.plist Updates**: Automatically updates Info.plist with icon references
- 🖼 **High-Quality Resizing**: Uses Core Graphics for optimal image quality
- 🚀 **Simple Usage**: Just run in your project directory with a PNG file

## Installation

### Using Swift Package Manager

```bash
git clone https://github.com/tornikegomareli/apple-launcher-icons.git
cd apple-launcher-icons
swift build -c release
sudo cp .build/release/apple-launcher-icons /usr/local/bin/
```

### From Source

```bash
swift build
swift run apple-launcher-icons [image-path]
```

## Usage

Navigate to your Xcode project directory and run:

```bash
apple-launcher-icons icon.png
```

### Options

- `--project-path, -p`: Specify project directory (default: current directory)
- `--force, -f`: Force overwrite existing icons (only needed if icons already exist)
- `--verbose, -v`: Show detailed output
- `--dry-run`: Preview changes without applying them

### Examples

```bash
# Generate icons for all detected platforms
apple-launcher-icons MyIcon.png

# Generate icons for a specific project directory
apple-launcher-icons MyIcon.png --project-path ~/MyApp

# Preview what will be generated
apple-launcher-icons MyIcon.png --dry-run

# Force overwrite existing icons
apple-launcher-icons MyIcon.png --force
```

## Requirements

- macOS 13.0 or later
- Swift 5.9 or later
- Source image must be:
  - PNG format
  - Square dimensions
  - At least 1024x1024 pixels

## How It Works

1. **Detection**: Scans your project directory for Xcode projects and their targets
2. **Generation**: Creates all required icon sizes for each detected platform
3. **Placement**: Puts icons in the appropriate Asset Catalog locations
4. **Configuration**: Updates Info.plist files to reference the new icons

## Supported Platforms

- ✅ iOS (iPhone & iPad)
- ✅ macOS
- ✅ watchOS
- ✅ tvOS
- ✅ visionOS

## Project Structure Detection

The tool looks for common project structures:
- `[ProjectName]/Assets.xcassets`
- `iOS/Assets.xcassets`
- `macOS/Assets.xcassets`
- `[ProjectName] Watch App/Assets.xcassets`
- And other standard Xcode project layouts

## License

MIT License - see LICENSE file for details