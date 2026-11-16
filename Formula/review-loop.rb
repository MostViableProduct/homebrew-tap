class ReviewLoop < Formula
  desc "Enforced Codex adversarial review inside Claude Code"
  homepage "https://github.com/MostViableProduct/review-loop"
  url "https://github.com/MostViableProduct/review-loop/releases/download/v1.3.0/review-loop-1.3.0.tar.gz"
  sha256 "ae9f379ca8c3e458224938b3850f5d841ca1808916c6a80b1aba1087bfb4bb3d"
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
