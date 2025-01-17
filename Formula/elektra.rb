class Elektra < Formula
  desc "Framework to access config settings in a global key database"
  homepage "https://libelektra.org/"
  url "https://www.libelektra.org/ftp/elektra/releases/elektra-0.9.3.tar.gz"
  sha256 "5022a6ebf004d892ded03fcf6eb3d223942a7fadd2d68f14d847d1f7f243e1d7"
  license "BSD-3-Clause"
  head "https://github.com/ElektraInitiative/libelektra.git"

  livecheck do
    url "https://www.libelektra.org/ftp/elektra/releases/"
    regex(/href=.*?elektra[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 "686d067559aa7e9f57b419a92c703d382abdf75b413b6d67854dec5ebf15873c" => :catalina
    sha256 "25e5bc4305fcde829a674d3734b9b18204d64acaf47027b322919703d9065b1f" => :mojave
    sha256 "218f8e1b129c4796301062e43a842b2d39f7996c204f69d9f15857304a8230d0" => :high_sierra
    sha256 "51eacbd0457fd00213cbaf21698af5ced9ba6e53058a3e3b22ee9e5b23503871" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  def install
    mkdir "build" do
      system "cmake", "..", "-DBINDINGS=cpp", "-DTOOLS=kdb;",
                            "-DPLUGINS=NODEP", *std_cmake_args
      system "make", "install"
    end

    # Avoid references to the Homebrew shims directory
    os = OS.mac? ? "mac" : "linux"
    inreplace Dir[prefix/"share/elektra/test_data/gen/gen/highlevel/*.check.sh"],
              HOMEBREW_SHIMS_PATH/"#{os}/super/", ""

    bash_completion.install "scripts/completion/kdb-bash-completion" => "kdb"
    fish_completion.install "scripts/completion/kdb.fish"
    zsh_completion.install "scripts/completion/kdb_zsh_completion" => "_kdb"
  end

  test do
    output = shell_output("#{bin}/kdb get system/elektra/version/infos/licence")
    assert_match "BSD", output
    shell_output("#{bin}/kdb plugin-list").split.each do |plugin|
      system "#{bin}/kdb", "plugin-check", plugin
    end
  end
end
