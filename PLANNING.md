# Apple Launcher Icons - Planning Document

## Project Overview
A CLI tool for generating app icons for Apple platforms (iOS, macOS, watchOS, tvOS, iPadOS, visionOS) from a single PNG file. The tool will automatically resize the image to all required dimensions and place them in the correct locations within the project structure.

## Architecture

### Core Components
- **Image Processing Module**: Handles image loading, resizing, and format conversions
- **Platform Configuration**: Defines icon requirements for each Apple platform
- **File System Manager**: Manages icon placement in correct directories
- **CLI Interface**: Command-line argument parsing and user interaction
- **Configuration Parser**: Reads and validates configuration files

### Data Model
- **IconTemplate**: Defines size, scale factor, and naming conventions for each icon variant
- **PlatformConfig**: Contains platform-specific requirements and paths
- **GenerationConfig**: User-provided settings for icon generation

## Technology Stack

### Language Options Analysis

**1. Go (Recommended)**
- **Pros**: 
  - Single binary distribution, no runtime dependencies
  - Excellent performance for image processing
  - Great standard library for CLI and file operations
  - Cross-platform compilation
  - Strong image manipulation libraries (imaging, resize)
- **Cons**: 
  - Smaller ecosystem compared to Node.js
  - Less native Apple platform integration

**2. Rust**
- **Pros**: 
  - Best-in-class performance
  - Memory safety guarantees
  - Excellent CLI frameworks (clap)
  - Great image processing crates (image, imageproc)
  - Single binary distribution
- **Cons**: 
  - Steeper learning curve
  - Longer development time
  - Smaller ecosystem for some tasks

**3. Swift**
- **Pros**: 
  - Native Apple development
  - Excellent Core Graphics integration
  - Direct Xcode project manipulation
  - Best for Apple-specific features
- **Cons**: 
  - Limited cross-platform support
  - Requires macOS for development
  - Distribution more complex outside Mac App Store

**4. TypeScript/Node.js**
- **Pros**: 
  - Huge ecosystem (Sharp for images)
  - Easy npm distribution
  - Rapid development
  - Great for web integration
- **Cons**: 
  - Requires Node.js runtime
  - Larger distribution size
  - Performance overhead

### Recommended Stack: Go

**Key Libraries**:
- **CLI Framework**: cobra or urfave/cli
- **Image Processing**: 
  - github.com/disintegration/imaging
  - github.com/nfnt/resize
- **Configuration**: viper (YAML/JSON/TOML support)
- **File Operations**: Standard library (os, path/filepath)
- **Logging**: logrus or zap
- **Testing**: Standard library + testify

## Project Structure
```
apple-launcher-icons/
├── cmd/
│   └── apple-launcher-icons/  # Main CLI entry point
├── internal/
│   ├── cli/                   # Command-line interface
│   ├── core/
│   │   ├── image/            # Image processing
│   │   ├── platforms/        # Platform configurations
│   │   └── generator/        # Icon generation logic
│   ├── config/               # Configuration parsing
│   └── utils/                # Utility functions
├── pkg/                      # Public API (if needed)
├── templates/                # Icon set templates
├── test/                     # Integration tests
├── examples/                 # Example configurations
├── docs/                     # Documentation
└── scripts/                  # Build and release scripts
```

## Testing Strategy
- Unit tests for image processing functions
- Integration tests for file system operations
- E2E tests for complete icon generation workflow
- Platform-specific validation tests
- Benchmark tests for performance

## Development Commands
- `make build`: Compile the project
- `make test`: Run all tests
- `make lint`: Check code style (golangci-lint)
- `make run`: Execute the CLI tool
- `make release`: Create release binaries for all platforms

## Environment Setup
- Go 1.21+
- golangci-lint for code quality
- goreleaser for releases
- Make for build automation

## Development Guidelines
- Follow platform naming conventions exactly
- Validate image dimensions before processing
- Provide clear error messages
- Support dry-run mode for testing
- Maintain backwards compatibility
- Use Go modules for dependency management

## Security Considerations
- Validate input file paths to prevent directory traversal
- Sanitize configuration inputs
- Handle file permissions appropriately
- Don't expose system paths in error messages

## Future Considerations
- Web-based GUI interface
- Figma/Sketch plugin integration
- CI/CD integration examples
- Icon validation against App Store requirements
- Support for adaptive icons
- Batch processing for multiple apps
- Icon preview generation
- Integration with fastlane
- Homebrew formula for easy installation