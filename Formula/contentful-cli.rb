require "language/node"

class ContentfulCli < Formula
  desc "Contentful command-line tools"
  homepage "https://github.com/contentful/contentful-cli"
  url "https://registry.npmjs.org/contentful-cli/-/contentful-cli-1.4.49.tgz"
  sha256 "4872354fbb79377737e2a138820024c9de1d676a06ab08d173cb063c051ea770"
  license "MIT"
  head "https://github.com/contentful/contentful-cli.git"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "9e2938304156320d619152415a4f2cc3c4b1146d4c07b8cf9046c8c364bbad14" => :catalina
    sha256 "52638d45ccaf0f33938eec1aee55136a4e54d7ae8565f29c504fe7496807dcaa" => :mojave
    sha256 "eeed9e33fd872bc91f0d13f6c7fbd0b076c6b316dbd4bbc60308214a16f9191e" => :high_sierra
    sha256 "e0f77c4ae8018e3a3df4298e47d7ad742c4e7ea9d0b9b449d9f2014aaa6a1f6c" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    output = shell_output("#{bin}/contentful space list 2>&1", 1)
    assert_match "🚨  Error: You have to be logged in to do this.", output
    assert_match "You can log in via contentful login", output
    assert_match "Or provide a management token via --management-token argument", output
  end
end
