class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.5.27-product.tar.gz"
  sha256 "aeaa6726e6ac5e055126f5cdf03807834ab03605b949546eca5fb785f3dd06ae"

  def install
    libexec.install Dir["*"]
    (bin/"sfs").write <<~SH
      #!/bin/bash
      export SFS_DIST_DIR="#{libexec}"
      exec "#{libexec}/bin/sfs" "\"
    SH
    chmod 0755, bin/"sfs"
  end

  test do
    system "#{bin}/sfs", "--help"
  end
end
