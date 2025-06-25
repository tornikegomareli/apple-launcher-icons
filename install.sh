#!/bin/bash

# Apple Launcher Icons Installation Script

echo "🎨 Apple Launcher Icons - Installation Script"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This tool is only supported on macOS"
    exit 1
fi

# Build the release version
echo "📦 Building release version..."
swift build -c release

if [ $? -ne 0 ]; then
    echo "❌ Build failed"
    exit 1
fi

# Create /usr/local/bin if it doesn't exist
if [ ! -d "/usr/local/bin" ]; then
    echo "📁 Creating /usr/local/bin directory..."
    sudo mkdir -p /usr/local/bin
fi

# Copy the binary
echo "📋 Installing apple-launcher-icons to /usr/local/bin..."
sudo cp .build/release/apple-launcher-icons /usr/local/bin/

if [ $? -ne 0 ]; then
    echo "❌ Installation failed. Please run with sudo."
    exit 1
fi

# Make it executable
sudo chmod +x /usr/local/bin/apple-launcher-icons

# Verify installation
if command -v apple-launcher-icons &> /dev/null; then
    echo "✅ Successfully installed!"
    echo ""
    echo "You can now use 'apple-launcher-icons' from anywhere:"
    echo "  apple-launcher-icons your-icon.png"
    echo ""
    apple-launcher-icons --version
else
    echo "⚠️  Installation completed but command not found in PATH"
    echo "Make sure /usr/local/bin is in your PATH"
    echo "Add this to your ~/.zshrc or ~/.bash_profile:"
    echo "  export PATH=\"/usr/local/bin:$PATH\""
fi