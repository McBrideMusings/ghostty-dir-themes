class Gdt < Formula
  desc "Per-directory color themes for the Ghostty terminal"
  homepage "https://github.com/McBrideMusings/ghostty-dir-themes"
  url "https://github.com/McBrideMusings/ghostty-dir-themes/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"

  depends_on "python@3"

  def install
    bin.install "gdt"
  end

  def caveats
    <<~EOS
      To enable automatic theme switching, generate the hook and source it:

        gdt --generate-hook
        echo 'source ~/.config/gdt/hook.zsh' >> ~/.zshrc

      Then restart your shell or run: source ~/.zshrc
    EOS
  end

  test do
    assert_match "gdt #{version}", shell_output("#{bin}/gdt --version")
  end
end
