# Homebrew Formula for AI Vault
#
# To use this formula:
# 1. Create a tap: brew tap dotCipher/ai-vault
# 2. Install: brew install ai-vault
#
# Or install directly from this file:
# brew install --build-from-source homebrew/ai-vault.rb

class AiVault < Formula
  desc "Own your data. Comprehensive archival of AI interactions across multiple platforms"
  homepage "https://github.com/dotCipher/ai-vault"
  url "https://github.com/dotCipher/ai-vault/archive/refs/tags/v3.5.1.tar.gz"
  sha256 "c8cf97f98a5c9f85982b2f663b9f8c99279debf5ed8386c6f4904ded62bc638a"
  license "MIT"

  depends_on "node@22"
  depends_on "pnpm"

  def install
    system "pnpm", "install", "--frozen-lockfile"
    system "pnpm", "run", "build"

    libexec.install Dir["*"]
    bin.install_symlink libexec/"dist/cli.js" => "ai-vault"
  end

  test do
    assert_match "ai-vault", shell_output("#{bin}/ai-vault --version")
  end
end
