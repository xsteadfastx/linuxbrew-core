require "language/node"

class FirebaseCli < Formula
  desc "Firebase command-line tools"
  homepage "https://firebase.google.com/docs/cli/"
  url "https://registry.npmjs.org/firebase-tools/-/firebase-tools-8.15.1.tgz"
  sha256 "56af1bda34de229e39e2131b26057faefa90ba05f470126eedcc3d31a6d61987"
  license "MIT"
  head "https://github.com/firebase/firebase-tools.git"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "a7acbb9b10ea392fc827a17739abc172d87ac4ba11618328e1d588fff014d442" => :catalina
    sha256 "3a5bfd216118f6bbc5243816938cd694c1a1caf3f69758a0436d2c9bd020e615" => :mojave
    sha256 "ea7f0e2ac0fb04be11c07daba842bc54f766b450bcb6a8f321c87daabb38a5f3" => :high_sierra
    sha256 "f5d86cea4c3422df8518a41641702f1bf1830bc22f021f5b77ad4202029fa4ee" => :x86_64_linux
  end

  depends_on "node"

  uses_from_macos "expect" => :test

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/firebase login:ci --no-localhost
      expect "Paste"
    EOS
    assert_match "authorization code", shell_output("expect -f test.exp")
  end
end
