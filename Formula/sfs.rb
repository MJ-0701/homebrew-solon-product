class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.5.91-product.tar.gz"
  sha256 "05bd5e9415c32d3c6b2de3610d8542fe6517eb74c6cc214cf167f59e7b0118eb"

  def install
    libexec.install Dir["*"]
    (bin/"sfs").write <<~SH
      #!/bin/bash
      export SFS_DIST_DIR="#{libexec}"
      exec "#{libexec}/bin/sfs" "$@"
    SH
    chmod 0755, bin/"sfs"
  end

  def caveats
    <<~EOS
      First-time project setup:
        cd /path/to/your-project
        sfs init --yes
        sfs status
        sfs guide

      Homebrew installs the global sfs CLI. Run `sfs init --yes` once inside
      each project where you want Solon files and state. Project-local
      command/skill adapters are optional: `sfs agent install all`.
      Later, run `sfs upgrade` inside a project; it self-upgrades the Homebrew
      runtime first, then updates that project's Solon files.

      Beginner guide:
        https://github.com/MJ-0701/solon-product/blob/main/BEGINNER-GUIDE.md
    EOS
  end

  test do
    system "#{bin}/sfs", "--help"
  end
end
