class Xclip < Formula
  desc "Command-line utility that is designed to run on any system with an X11"
  homepage "https://github.com/astrand/xclip"
  url "https://github.com/astrand/xclip/archive/0.13.tar.gz"
  sha256 "ca5b8804e3c910a66423a882d79bf3c9450b875ac8528791fb60ec9de667f758"
  license "GPL-2.0-or-later"
  revision OS.mac? ? 1 : 4

  bottle do
    cellar :any_skip_relocation
    sha256 "2229de2d3139a5a916be1d7e6c3227ef989ff20ce4322f0881eaeb22ee34caf1" => :catalina
    sha256 "7bacdf14b8a248a969952c6cba098e01b15d63b280b95a453164d2b0117400dc" => :mojave
    sha256 "4ff44edecff889254b56f12f261127e90f20c8b0f8d10e0d7f6b41788be0b2e4" => :high_sierra
    sha256 "2f2c0e046087e8af545bab9db1cb7b2a1d3dcdcbfca3d1720b74bd608ab3009a" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libx11"
  depends_on "libxmu"

  def install
    system "autoreconf", "-fiv"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/xclip", "-version"
  end
end
