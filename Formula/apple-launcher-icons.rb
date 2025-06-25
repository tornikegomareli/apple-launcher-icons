class AppleLauncherIcons < Formula
  desc "Generate app icons for Apple platforms from a single PNG file"
  homepage "https://github.com/tornikegomareli/apple-launcher-icons"
  url "https://github.com/tornikegomareli/apple-launcher-icons/releases/download/v0.1.0/apple-launcher-icons-macos.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on :macos

  def install
    bin.install "apple-launcher-icons"
  end

  test do
    assert_match "0.1.0", shell_output("#{bin}/apple-launcher-icons --version")
  end
end