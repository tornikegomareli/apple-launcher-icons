class AppleLauncherIcons < Formula
  desc "Generate app icons for Apple platforms from a single PNG file"
  homepage "https://github.com/tornikegomareli/apple-launcher-icons"
  url "https://github.com/tornikegomareli/apple-launcher-icons/releases/download/v0.1.1/apple-launcher-icons-macos.tar.gz"
  sha256 "8cf77a25675a469843099342330b1fe28846b073335b7582129f65758da5f5fe"
  license "MIT"

  depends_on :macos

  def install
    bin.install "apple-launcher-icons"
  end

  test do
    assert_match "0.1.1", shell_output("#{bin}/apple-launcher-icons --version")
  end
end