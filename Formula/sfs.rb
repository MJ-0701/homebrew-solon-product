# typed: false
# frozen_string_literal: true

# Homebrew formula for the Solon Product SFS global CLI runtime.
class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"

  # Replace VERSION and SHA256 when cutting a public release tarball.
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "2f11dfd424e1e2a1a970e1d5fded383b4a4aaed76fd7ebf5bc4f7d34ee656c42"

  def install
    libexec.install Dir["*"]
    libexec.install %w[.gitattributes .gitignore .github .claude-plugin].select { |path| File.exist?(path) }
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
    system bin/"sfs", "--help"
  end
end
