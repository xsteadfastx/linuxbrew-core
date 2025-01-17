class Cxxtest < Formula
  include Language::Python::Virtualenv

  desc "C++ unit testing framework similar to JUnit, CppUnit and xUnit"
  homepage "https://cxxtest.com/"
  url "https://github.com/CxxTest/cxxtest/releases/download/4.4/cxxtest-4.4.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/c/cxxtest/cxxtest_4.4.orig.tar.gz"
  sha256 "1c154fef91c65dbf1cd4519af7ade70a61d85a923b6e0c0b007dc7f4895cf7d8"
  license "LGPL-3.0"
  revision OS.mac? ? 2 : 3

  bottle do
    cellar :any_skip_relocation
    sha256 "40c95a78befc9212653a872f53f7b87669d6ed855da71355a6324571cfc09f9c" => :catalina
    sha256 "19feab27f801c6af7cba8075900cdb96f492244d06fc49ed9b4c943b1f13777e" => :mojave
    sha256 "c989ac0116f6c42404580610e42f467af4d476b4107e2303d47da4f576a394f2" => :high_sierra
    sha256 "d81340d817944f1d148c0e9ea06f3750100b76ee17472876a5d440d55b3b1a87" => :x86_64_linux
  end

  depends_on "python@3.9"

  def install
    venv = virtualenv_create(libexec, Formula["python@3.9"].opt_bin/"python3")
    venv.pip_install_and_link buildpath/"python"

    include.install "cxxtest"
    doc.install Dir["doc/*"]
  end

  test do
    testfile = testpath/"MyTestSuite1.h"
    testfile.write <<~EOS
      #include <cxxtest/TestSuite.h>

      class MyTestSuite1 : public CxxTest::TestSuite {
      public:
          void testAddition(void) {
              TS_ASSERT(1 + 1 > 1);
              TS_ASSERT_EQUALS(1 + 1, 2);
          }
      };
    EOS

    system bin/"cxxtestgen", "--error-printer", "-o", testpath/"runner.cpp", testfile
    system ENV.cxx, "-o", testpath/"runner", testpath/"runner.cpp"
    system testpath/"runner"
  end
end
