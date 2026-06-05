# typed: false
# frozen_string_literal: true

# Homebrew formula for the Solon Product SFS global CLI runtime.
class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"

  # Replace VERSION and 9ffdce3d8a1a2e5b58364cacf0c0c007874e215d39538e9c5e28ad5969810d47 when cutting a public release tarball.
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.8.25.tar.gz"
  sha256 "9ffdce3d8a1a2e5b58364cacf0c0c007874e215d39538e9c5e28ad5969810d47"

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
