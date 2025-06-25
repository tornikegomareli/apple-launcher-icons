# Homebrew Tap Setup Instructions

To make `apple-launcher-icons` installable via Homebrew, you need to create a tap repository:

## 1. Create a new GitHub repository

Create a new repository named `homebrew-tap` in your GitHub account:
- Go to https://github.com/new
- Name it: `homebrew-tap`
- Make it public
- Don't initialize with README

## 2. Set up the tap repository

```bash
# Clone the new repository
git clone https://github.com/tornikegomareli/homebrew-tap.git
cd homebrew-tap

# Create Formula directory
mkdir Formula

# Copy the formula file
cp /path/to/apple-launcher-icons/Formula/apple-launcher-icons.rb Formula/

# Commit and push
git add .
git commit -m "Add apple-launcher-icons formula"
git push origin main
```

## 3. Users can then install via:

```bash
# Add your tap
brew tap tornikegomareli/tap

# Install the tool
brew install apple-launcher-icons
```

## Alternative: Direct Formula Installation

Users can also install directly without tapping:

```bash
brew install tornikegomareli/tap/apple-launcher-icons
```

## Updating the Formula

When you release new versions:
1. Update the `url` in the formula to point to the new release
2. Update the `sha256` with the new checksum
3. Update the version in the `test` block
4. Commit and push to the tap repository