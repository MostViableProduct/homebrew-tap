class ReviewLoop < Formula
  desc "Enforced Codex adversarial review inside Claude Code"
  homepage "https://github.com/MostViableProduct/review-loop"
  url "https://github.com/MostViableProduct/review-loop/releases/download/v1.0.1/review-loop-1.0.1.tar.gz"
  sha256 "6541cf16116e17913cc22d2a4e60fc0bf43540359fe948d5f25b6dc2ff8f9294"
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
