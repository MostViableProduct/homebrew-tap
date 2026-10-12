class ReviewLoop < Formula
  desc "Enforced Codex adversarial review inside Claude Code"
  homepage "https://github.com/MostViableProduct/review-loop"
  url "https://github.com/MostViableProduct/review-loop/releases/download/v1.1.0/review-loop-1.1.0.tar.gz"
  sha256 "d4f6fba11693d7b7f12af71dfa30e6722232736ece57eab50800a44c4652f63e"
  license "MIT"

  depends_on "git"
  depends_on :macos
  depends_on "node"

  def install
    libexec.install "cli", "plugin", "package.json"
    (bin/"review-loop").write <<~SH
      #!/bin/sh
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/cli/review-loop.mjs" "$@"
    SH
  end

  def caveats
    <<~EOS
      Next, in a normal terminal with Claude Code closed:
        review-loop setup

      To remove review-loop completely, in this order:
        review-loop uninstall
        brew uninstall review-loop
    EOS
  end

  test do
    system bin/"review-loop", "selftest"
    assert_match "review-loop #{version}", shell_output("#{bin}/review-loop --version")
  end
end
