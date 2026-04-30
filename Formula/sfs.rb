class Sfs < Formula
  desc "Solon Product SFS runtime for AI-native product work"
  homepage "https://github.com/MJ-0701/solon-product"
  url "https://github.com/MJ-0701/solon-product/archive/refs/tags/v0.5.27-product.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/sfs" => "sfs"
  end

  test do
    system "#{bin}/sfs", "--help"
  end
end
