class Xmrig < Formula
  desc "Monero (XMR) CPU miner"
  homepage "https://github.com/xmrig/xmrig"
  url "https://github.com/xmrig/xmrig/archive/v6.5.0.tar.gz"
  sha256 "a2dcf820d86d5d1073bf86eb3d956c7ee0ecf132e71a55ce67865bedebe19057"
  license "GPL-3.0-or-later"
  head "https://github.com/xmrig/xmrig.git"

  livecheck do
    url "https://github.com/xmrig/xmrig/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 "70e9ad31023bc22fb812f002b97e4595515ea0f8d17ac4dcdcb5ec0672a853ad" => :catalina
    sha256 "1386fd6f391cf11ddda88d58148e30757c3e229b51b011e7ea22531faa16e84d" => :mojave
    sha256 "f466b323948689846778c77d242b6c4b34347016a1047c516e44688c095e1643" => :high_sierra
    sha256 "5700a5bdc951c06eda1f88a6753c4f2f24dc81a57959bdb8d865834c7d6b8963" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "hwloc"
  depends_on "libmicrohttpd"
  depends_on "libuv"
  depends_on "openssl@1.1"

  def install
    mkdir "build" do
      system "cmake", "..", "-DWITH_CN_GPU=OFF", *std_cmake_args
      system "make"
      bin.install "xmrig"
    end
    pkgshare.install "src/config.json"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/xmrig -V")
    test_server="donotexist.localhost:65535"
    timeout=10
    begin
      read, write = IO.pipe
      pid = fork do
        exec "#{bin}/xmrig", "--no-color", "--max-cpu-usage=1", "--print-time=1",
             "--threads=1", "--retries=1", "--url=#{test_server}", out: write
      end
      start_time=Time.now
      loop do
        assert (Time.now - start_time <= timeout), "No server connect after timeout"
        break if read.gets.include? "#{test_server} DNS error: \"unknown node or service\""
      end
    ensure
      Process.kill("SIGINT", pid)
    end
  end
end
