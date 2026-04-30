class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.5.28-product.tar.gz"
  sha256 "aee8486aedaa896f5a0552f9a04c216d1e27620594a0588166e9c0dea537a51b"

  def install
    libexec.install Dir["*"]
    (bin/"sfs").write <<~SH
      #!/bin/bash
      export SFS_DIST_DIR="#{libexec}"
      exec "#{libexec}/bin/sfs" "$@"
    SH
    chmod 0755, bin/"sfs"
  end

  test do
    system "#{bin}/sfs", "--help"
  end
end
