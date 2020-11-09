class PandocCrossref < Formula
  desc "Pandoc filter for numbering and cross-referencing"
  homepage "https://github.com/lierdakil/pandoc-crossref"
  url "https://hackage.haskell.org/package/pandoc-crossref-0.3.8.2/pandoc-crossref-0.3.8.2.tar.gz"
  sha256 "6a54e9d5c29b6d74db17c9fb29eb3e2d164417079fccb10d9807f3026cf73b97"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
  end

  bottle do
    sha256 "723e2b9c88b96513fb9f1eac0d45a87723487aff9d5e3063e6023d4843de537d" => :catalina
    sha256 "6595989164be9000d8081f2908f84642f190084fd04f8cf6dd0ba61a4ec5b657" => :mojave
    sha256 "5c0b8fdda9d69df885f037596068d30e2271e44fb1e45452f32d0132910a3a3e" => :high_sierra
    sha256 "dea22e332156fe2ccb9517e1c2e6d788caac7de99a3cdfaa02fb3aa1cfd01be0" => :x86_64_linux
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build
  depends_on "pandoc"

  uses_from_macos "unzip" => :build
  uses_from_macos "zlib"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"hello.md").write <<~EOS
      Demo for pandoc-crossref.
      See equation @eq:eqn1 for cross-referencing.
      Display equations are labelled and numbered

      $$ P_i(x) = \\sum_i a_i x^i $$ {#eq:eqn1}
    EOS
    system Formula["pandoc"].bin/"pandoc", "-F", bin/"pandoc-crossref", "-o", "out.html", "hello.md"
    assert_match "∑", (testpath/"out.html").read
  end
end
