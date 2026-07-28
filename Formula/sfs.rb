# typed: false
# frozen_string_literal: true

# Homebrew formula for the Solon Product SFS global CLI runtime.
class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"

  # Replace VERSION and SHA256 when cutting a public release tarball.
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.13.1.tar.gz"
  sha256 "8f5b42eb5f23f9d7f5532cbda751062bc6994a573370d46fa3508295c664e400"

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
