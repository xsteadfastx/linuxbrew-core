class IrcdHybrid < Formula
  desc "High-performance secure IRC server"
  homepage "https://www.ircd-hybrid.org/"
  url "https://downloads.sourceforge.net/project/ircd-hybrid/ircd-hybrid/ircd-hybrid-8.2.34/ircd-hybrid-8.2.34.tgz"
  sha256 "fcf872776a066b1623990bd438696a31fd79e184c688ffe5ef1e9c91046337c8"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/ircd-hybrid[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 "4162ae16bfb1a7ba5a32f2c3751f170768975d825628584919f96b0407a500af" => :catalina
    sha256 "e5c3e5581272ce69248176c26ce9249410d026dff145985384ab59a2e39cfece" => :mojave
    sha256 "2ac0770f9438416d323a00c55c3dfe32dc845aec32a2cc473270948893fabf56" => :high_sierra
    sha256 "aa38b576a2e8e7e579772efe7e4dbbd936c8d8a7b55e7eb226f8e3dd9857d4f8" => :x86_64_linux
  end

  depends_on "openssl@1.1"

  conflicts_with "ircd-irc2", because: "both install an `ircd` binary"

  # ircd-hybrid needs the .la files
  skip_clean :la

  def install
    ENV.deparallelize # build system trips over itself

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}",
                          "--enable-openssl=#{Formula["openssl@1.1"].opt_prefix}"
    system "make", "install"
    etc.install "doc/reference.conf" => "ircd.conf"
  end

  def caveats
    <<~EOS
      You'll more than likely need to edit the default settings in the config file:
        #{etc}/ircd.conf
    EOS
  end

  plist_options manual: "ircd"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <false/>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/ircd</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/ircd.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    # Won't run as root
    return if Process.uid.zero?

    system "#{bin}/ircd", "-version"
  end
end
