class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.5.72-product.tar.gz"
  sha256 "479df4cc6221112818101723eb02dd52b935bd655bccb2531254343e92d30401"

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
      each project where you want Solon files, state, and agent adapters.
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
