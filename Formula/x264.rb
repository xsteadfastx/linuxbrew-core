class X264 < Formula
  desc "H.264/AVC encoder"
  homepage "https://www.videolan.org/developers/x264.html"
  license "GPL-2.0"
  head "https://code.videolan.org/videolan/x264.git"

  stable do
    # the latest commit on the stable branch
    url "https://code.videolan.org/videolan/x264.git",
        revision: "98ee9d2f215326feeb221a4434957fa586d55c18"
    version "r3027"
  end

  # There's no guarantee that the versions we find on the `release-macos` index
  # page are stable but there didn't appear to be a different way of getting
  # the version information at the time of writing.
  livecheck do
    url "https://artifacts.videolan.org/x264/release-macos/"
    regex(%r{href=.*?x264[._-](r\d+)[._-][\da-z]+/?["' >]}i)
  end

  bottle do
    cellar :any
    sha256 "007c005fa1414651a0a0b2e753bee85ecbf0bc2242d7d56d0779a9671266819c" => :catalina
    sha256 "3e06b470e5af895f539e1ac145f21e53fa6a163941bca5e43dac59c1344e9adb" => :mojave
    sha256 "d0ced8a151305f396c35e810c3eaeb35ab102cf704426521078618ca65da02ce" => :high_sierra
    sha256 "13fc1695f50beb9ed99fe639246e4c8b3146b18a72cd78da7ae936a595ec9a06" => :x86_64_linux
  end

  depends_on "nasm" => :build

  if MacOS.version <= :high_sierra
    # Stack realignment requires newer Clang
    # https://code.videolan.org/videolan/x264/-/commit/b5bc5d69c580429ff716bafcd43655e855c31b02
    depends_on "gcc"
    fails_with :clang
  end

  # update config.* and configure: add Apple Silicon support.
  # upstream PR https://code.videolan.org/videolan/x264/-/merge_requests/35
  # Can be removed once it gets merged into stable branch
  patch do
    url "https://code.videolan.org/videolan/x264/-/commit/eb95c2965299ba5b8598e2388d71b02e23c9fba7.diff?full_index=1"
    sha256 "7cdc60cffa8f3004837ba0c63c8422fbadaf96ccedb41e505607ead2691d49b9"
  end

  def install
    # Work around Xcode 11 clang bug
    # https://bitbucket.org/multicoreware/x265/issues/514/wrong-code-generated-on-macos-1015
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010

    args = %W[
      --prefix=#{prefix}
      --disable-lsmash
      --disable-swscale
      --disable-ffms
      --enable-shared
      --enable-static
      --enable-strip
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdint.h>
      #include <x264.h>

      int main()
      {
          x264_picture_t pic;
          x264_picture_init(&pic);
          x264_picture_alloc(&pic, 1, 1, 1);
          x264_picture_clean(&pic);
          return 0;
      }
    EOS
    system ENV.cc, "-L{lib}", "test.c", "-lx264", "-o", "test"
    system "./test"
  end
end
